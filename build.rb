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
  FileUtils.mkpath workingDir
  FileUtils.copy_entry "/asciidoc/lib/revealjs", "#{workingDir}/reveal.js"
  FileUtils.copy_entry "#{$image_dir}", "#{workingDir}/static"
  FileUtils.copy_entry "#{$video_dir}", "#{workingDir}/static"
  FileUtils.copy_entry "#{$generated_images_dir}", "#{workingDir}/static"
  FileUtils.copy_entry "#{$custom_config_dir}", "#{workingDir}/config"

  attributes = "imagesdir=static revealjsdir=reveal.js revealjs_theme=#{$theme} customcss=config/revealjs.css"
  attributes += $custom_attributes
  Asciidoctor.convert_file indexFile(composite), backend: 'revealjs', safe: :unsafe,
                           to_file: "#{revealJSOutFile(composite)}", :attributes => attributes
end

def buildAsciiDocHtml(composite)
  print "Building asciidoc html...\n"
  workingDir = $out_dir + '/' + composite + $html_out_dir
  FileUtils.mkpath workingDir
  FileUtils.copy_entry "#{$image_dir}", "#{workingDir}/static"
  FileUtils.copy_entry "#{$video_dir}", "#{workingDir}/static"
  Asciidoctor.convert_file indexFile(composite), safe: :unsafe, to_file: "#{workingDir}/#{composite}.html", :attributes => "imagesdir=static" + $custom_attributes
end

def buildAsciidocPdf(composite)
  print "Building asciidoc pdf...\n"
  workingDir = $out_dir + '/' + composite + $asciidoc_pdf_out_dir
  FileUtils.mkpath workingDir
  FileUtils.copy_entry "#{$image_dir}", "#{$pdf_images_dir}"
  FileUtils.copy_entry "#{$video_dir}", "#{$pdf_images_dir}"
  FileUtils.copy_entry "#{$generated_images_dir}", "#{$pdf_images_dir}"
  Asciidoctor.convert_file indexFile(composite), safe: :unsafe, to_file: "#{workingDir}/#{composite}.pdf", backend: 'pdf', :attributes => "imagesdir=#{$pdf_images_dir} allow-uri-read" + $custom_attributes
end

def slidesPdfWorkingDir(composite)
  return $out_dir + '/' + composite + $slides_pdf_out_dir
end

def buildSlidesPdf(composite)
  print "Building slides pdf...\n"
  workingDir = slidesPdfWorkingDir(composite)
  FileUtils.mkpath workingDir

  inputFile = "file://#{escapeString(revealJSOutFile(composite))}"
  outputFile = "#{escapeString(slidesPdfWorkingDir(composite) +'/' + composite) + '.pdf'}"
  #%x(cd /asciidoc/lib/decktape && node decktape.js #{inputFile} #{outputFile})
  %x(cd /asciidoc/lib/decktape && node decktape.js --size 1238x875 #{inputFile} #{outputFile})
end
