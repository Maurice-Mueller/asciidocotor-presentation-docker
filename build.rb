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
  generateDirectoryStructure(composite)
  workingDir = revealjsOutDir(composite)
  _compositeDir = compositeDir(composite)

  FileUtils.mkpath workingDir
  copyResources(_compositeDir, "#{workingDir}/static")
  FileUtils.copy_entry "/asciidoc/lib/revealjs", "#{workingDir}/reveal.js"
  FileUtils.copy_entry "/asciidoc/revealjs_config", "#{workingDir}/config"

  attributes = "imagesdir=static revealjsdir=reveal.js revealjs_theme=#{$theme} customcss=config/revealjs.css"
  attributes += customAttributesFor(composite)
  Asciidoctor.convert_file indexFile(composite), backend: 'revealjs', safe: :unsafe,
                           to_file: "#{revealjsOutFile(composite)}", :attributes => attributes
end

def buildAsciiDocHtml(composite)
  print "Building asciidoc html...\n"
  generateDirectoryStructure(composite)
  _compositeDir = compositeDir(composite)
  workingDir =  _compositeDir + $html_out_dir

  FileUtils.mkpath workingDir
  copyResources(_compositeDir, "#{workingDir}/static")

  Asciidoctor.convert_file indexFile(composite), safe: :unsafe, to_file: "#{workingDir}/#{escapeString(composite)}.html", :attributes => "imagesdir=static" + customAttributesFor(composite)
end

def buildAsciiDocPdf(composite)
  print "Building asciidoc pdf...\n"
  generateDirectoryStructure(composite)
  _compositeDir = compositeDir(composite)
  workingDir = _compositeDir + $asciidoc_pdf_out_dir
  pdf_images_dir_temp = _compositeDir + $pdf_images_dir

  copyResources(_compositeDir, pdf_images_dir_temp)

  FileUtils.mkpath workingDir
  Asciidoctor.convert_file indexFile(composite), safe: :unsafe, to_file: "#{workingDir}/#{composite}.pdf", backend: 'pdf', :attributes => "imagesdir=#{pdf_images_dir_temp} allow-uri-read" + customAttributesFor(composite)

  FileUtils.rm_rf(pdf_images_dir_temp)
end

def buildSlidesPdf(composite)
  print "Building slides pdf...\n"
  generateDirectoryStructure(composite)
  workingDir = compositeDir(composite) + $slides_pdf_out_dir
 
  FileUtils.mkpath workingDir
  inputFile = "file://#{revealjsOutFile(composite)}"
  outputFile = workingDir + '/' + escapeString(composite) + '-slides.pdf'
  print(%x(cd /asciidoc/lib/decktape && node decktape --chrome-arg=--no-sandbox --size 1238x875 #{inputFile} #{outputFile}))
end
