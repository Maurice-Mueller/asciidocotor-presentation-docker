require 'rubygems'
require 'bundler/setup'
require './config'
require './extensions'
require 'asciidoctor'
require 'asciidoctor-pdf'
require 'asciidoctor-revealjs'
require 'asciidoctor-diagram'


def buildRevealJS(composite)
  print "Building reveal.js...\n"
  workingDir = revealJSWorkingDir(composite)

  compositeEscaped = escapeString($root_dir + '/' + composite)

  FileUtils.mkpath workingDir
  FileUtils.copy_entry "/asciidoc/lib/revealjs", "#{workingDir}/reveal.js"
  FileUtils.copy_entry "#{compositeEscaped + $image_dir}", "#{workingDir}/static"
  FileUtils.copy_entry "#{compositeEscaped + $video_dir}", "#{workingDir}/static"
  FileUtils.copy_entry "#{compositeEscaped + $generated_images_dir}", "#{workingDir}/static"
  #FileUtils.copy_entry "#{compositeEscaped}/#{$custom_config_dir}", "#{workingDir}/config"

  attributes = "imagesdir=static revealjsdir=reveal.js revealjs_theme=#{$theme} customcss=config/revealjs.css"
  attributes += customAttributesFor(composite)
  Asciidoctor.convert_file indexFile(composite), backend: 'revealjs', safe: :unsafe,
                           to_file: "#{revealJSOutFile(composite)}", :attributes => attributes
end

def buildAsciiDocHtml(composite)
  print "Building asciidoc html...\n"
  compositeEscaped = escapeString(composite)
  compositeDir = $root_dir + '/' + compositeEscaped
  workingDir =  $root_dir + '/' + compositeEscaped + $html_out_dir
  FileUtils.mkpath workingDir
  FileUtils.copy_entry "#{compositeDir + $image_dir}", "#{workingDir}/static"
  FileUtils.copy_entry "#{compositeDir + $video_dir}", "#{workingDir}/static"
  FileUtils.copy_entry "#{compositeDir + $generated_images_dir}", "#{workingDir}/static"
  Asciidoctor.convert_file indexFile(composite), safe: :unsafe, to_file: "#{workingDir}/#{compositeEscaped}.html", :attributes => "imagesdir=static" + $custom_attributes
end

def buildAsciidocPdf(composite)
  print "Building asciidoc pdf...\n"
  compositeEscaped = escapeString(composite)
  compositeDir = $root_dir + '/' + compositeEscaped
  workingDir = compositeDir + $asciidoc_pdf_out_dir
  pdf_images_dir_temp = compositeDir + $pdf_images_dir

  FileUtils.mkpath workingDir
  FileUtils.copy_entry "#{compositeDir + $image_dir}", "#{pdf_images_dir_temp}"
  FileUtils.copy_entry "#{compositeDir + $video_dir}", "#{pdf_images_dir_temp}"
  FileUtils.copy_entry "#{compositeDir + $generated_images_dir}", "#{pdf_images_dir_temp}"
  Asciidoctor.convert_file indexFile(composite), safe: :unsafe, to_file: "#{workingDir}/#{composite}.pdf", backend: 'pdf', :attributes => "imagesdir=#{pdf_images_dir_temp} allow-uri-read" + customAttributesFor(composite)

  FileUtils.rm_rf(pdf_images_dir_temp)
end

def slidesPdfWorkingDir(composite)
  return $root_dir + '/' + escapeString(composite + $slides_pdf_out_dir)
end

def buildSlidesPdf(composite)
  print "Building slides pdf...\n"
  workingDir = slidesPdfWorkingDir(composite)
  FileUtils.mkpath workingDir

  inputFile = "file://#{escapeString(revealJSOutFile(composite))}"
  outputFile = "#{escapeString(slidesPdfWorkingDir(composite) +'/' + composite) + '-slides.pdf'}"
  #%x(cd /asciidoc/lib/decktape && node decktape.js #{inputFile} #{outputFile})
  print(%x(cd /asciidoc/lib/decktape && node decktape --chrome-arg=--no-sandbox --size 1238x875 #{inputFile} #{outputFile}))
end
