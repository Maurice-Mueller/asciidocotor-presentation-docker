#!/usr/bin/env rake

require 'rubygems'
require './build'

def clearTaskList(argv)
  argv.each do |arg|
    task arg.to_sym do
      ;
    end
  end
end

def compositesDirectories
  currentDir = Dir.pwd
  Dir.chdir($root_dir)
  dirs = Dir.glob('*').select {|f| File.directory? f and !(f.start_with? '.')}
  Dir.chdir(currentDir)
  return dirs
end

def buildingComposites(argv)
  argv.shift
  if(argv.empty?)
    return compositesDirectories
  end
  clearTaskList(argv)
  return argv
end

task :'build-all' do
  buildingComposites(ARGV).each {|composite|
    buildRevealJS(composite)
    buildSlidesPdf(composite)
    buildAsciiDocHtml(composite)
    buildAsciiDocPdf(composite)
  }
end

task :'build-revealjs' do
  buildingComposites(ARGV).each {|composite|
    print "Building composite <" + composite + ">\n"
    buildRevealJS(composite)
  }
end

task :'build-pdf' do
  buildingComposites(ARGV).each {|composite|
    buildAsciiDocPdf(composite)
  }
end

task :'build-pdf-slides' do
  buildingComposites(ARGV).each {|composite|
    buildSlidesPdf(composite)
  }
end

task :'build-html' do
  buildingComposites(ARGV).each {|composite|
    buildAsciiDocHtml(composite)
  }
end

task :build => :'build-revealjs'
