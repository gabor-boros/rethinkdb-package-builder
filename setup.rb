#!/usr/bin/env ruby

require 'fileutils'
require 'optparse'

# Pro tip: You might have to run "sudo setup.rb ..."

# To save time and space, we build images for support libs for
# specific commits like v2.3.7 and b2365be (for v2.4.x), instead of
# all commits.

basedir = Dir.pwd()

options = {
  :commit => "v2.3.7",
  :support_commit => "v2.3.7",
  :support => false,
  :builds => false,
  :packages => false,
  :copy => false,
  :distro => nil,
  :dist => false,
}
parser = OptionParser.new { |opts|
  opts.banner = "Usage: ./setup.rb [options]"
  opts.on("-c", "--commit COMMIT", "The commit to build packages for (default v2.3.7)") { |c|
    if c[0] == "v" || c.length == 9
      options[:commit] = c
    else
      raise "Commit must be \"v...\" or be hash of length 9"
    end
  }
  opts.on("--[no-]support", "Build support (default on)") { |s|
    options[:support] = s
  }
  opts.on("--[no-]packages", "Build packages (default off)") { |p|
    options[:packages] = p
    if p
      options[:support] = true
    end
  }
  opts.on("--[no-]builds", "Build builds (default on)") { |b|
    options[:builds] = b
    if b
      options[:support] = true
    end
  }
  opts.on("--distro DISTRO", "The distro to build packages for (default all)") { |d|
    if d == "all"
      options[:distro] = nil
    else
      options[:distro] = d
    end
  }
  opts.on("--dist", "Builds dist .tgz source file") { |b|
    options[:dist] = b
    if b
      options[:support] = true
    end
  }
  opts.on("--copy-dirs", "Copies packages directory to artifacts/") { |b|
    options[:copy] = (b ? :dir : false)
  }
  opts.on("--copy-pkgs", "Copies debs and rpms to artifacts/pkgs") { |b|
    options[:copy] = (b ? :pkgs : false)
  }
  opts.on("--v24support", "Build support libs for v2.4.x") { |b|
    # b2365be is the "Parallelize deb-build" commit in v2.4.x.
    options[:support_commit] = "b2365bef6"
  }
}

parser.parse!

commit = options[:commit]
support_commit = options[:support_commit]
package_args = "--build-arg commit=#{commit}"
checkout_args = "#{package_args} --build-arg support_commit=#{support_commit}"
build_args = "#{package_args}"
support_args = "--build-arg commit=#{support_commit}"

# distros is in order of priority.
distros = [
# latest production releases
  "bionic",
  "centos8",
  "buster",
# past production releases
  "centos7",
  "stretch",
  "jessie",
  "xenial",
  "trusty",
# unimportant releases
  "eoan",
  "disco",
]

if options[:distro] != nil
  distros.delete_if { |d| options[:distro] != d }
end

if distros.empty?
  raise "Invalid distro"
end

# First build the base image
Dir.chdir("rdbcheckout") {
  system "docker build -t samrhughes/rdbcheckout ." or raise "build rdbcheckout fail"
}

# Then do system builds
distros.each { |distro|
  Dir.chdir("#{distro}/system") {
    system "docker build -t samrhughes/rdb-#{distro}-system ." or raise "build rdb-#{distro}-system fail"
  }
}

if options[:support]
  # Then do support builds
  distros.each { |distro|
    Dir.chdir("#{distro}/support") {
      system "docker build -t samrhughes/rdb-#{distro}-support:#{support_commit} #{support_args} ." or raise "build rdb-#{distro}-support fail"
    }
  }

  # Then do checkouts
  distros.each { |distro|
    Dir.chdir("#{distro}/checkout") {
      system "docker build -t samrhughes/rdb-#{distro}-checkout:#{commit} #{checkout_args} ." or raise "build rdb-#{distro}-checkout fail"
    }
  }

  if options[:builds]
    # Then do builds, if we want that.
    Dir.chdir("build") {
      distros.each { |distro|
        system "docker build -t samrhughes/rdb-#{distro}-build:#{commit} #{build_args} --build-arg distro=#{distro} ." or raise "build rdb-#{distro}-build fail"
      }
    }
  end

  if options[:dist]
    Dir.chdir("dist") {
      # We only need one dist file, it doesn't depend on OS.  So we pick a recent LTS ubuntu.
      system "docker build -t samrhughes/rdb-bionic-dist:#{commit} #{build_args} ." or raise "build rdb-bionic-dist fail"
    }

    puts "Copying dist file into one pkgs directory..."
    FileUtils.mkdir_p("artifacts/pkgs")
    cmd = "docker run --rm -v #{basedir}/artifacts:/artifacts samrhughes/rdb-bionic-dist:#{commit} bash -c \"cp \\$(find /platform/rethinkdb/build/packages -name '*.tgz') /artifacts/pkgs\""
    puts "Executing #{cmd}"
    system cmd or raise "copy-dist fail"
    puts "Done copying dist."
  end

  if options[:packages]
    # And build packages, if we want that.
    distros.each { |distro|
      Dir.chdir("#{distro}/package") {
        system "docker build -t samrhughes/rdb-#{distro}-package:#{commit} #{package_args} ." or raise "build rdb-#{distro}-package fail"
      }
    }

    if options[:copy] == :dir
      # TODO: Use rsync for --copy-dirs.  We'd have to install it on
      # the images though.
      distros.each { |distro|
        puts "Copying dir for distro #{distro}..."
        FileUtils.mkdir_p("artifacts/#{distro}")

        system "docker run --rm -v #{basedir}/artifacts:/artifacts samrhughes/rdb-#{distro}-package:#{commit} cp -R /platform/rethinkdb/build/packages /artifacts/#{distro}" or raise "copy-dirs #{distro}-package fail"
      }
      puts "Done copying dirs."
    elsif options[:copy] == :pkgs
      distros.each { |distro|
        puts "Copying deb/rpms for distro #{distro} into one directory..."
        FileUtils.mkdir_p("artifacts/pkgs")

        cmd = "docker run --rm -v #{basedir}/artifacts:/artifacts samrhughes/rdb-#{distro}-package:#{commit} bash -c \"cp \\$(find /platform/rethinkdb/build/packages -name '*.deb' -or -name '*.rpm') /artifacts/pkgs\""
        puts "Executing #{cmd}"
        system cmd or raise "copy-pkgs #{distro}-package fail"
        puts "Done copying debs."
      }
    end
  end
end
