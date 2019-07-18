require 'rubygems'

def escapeString(s)
  s.gsub(/ /, '\ ')
end

def compositeDir(composite)
   return $root_dir + '/' + escapeString(composite)
end

def revealjsOutDir(composite)
   return compositeDir(composite) + $revealjs_out_dir
end

def revealjsOutFile(composite)
  return revealjsOutDir(composite) + '/' + escapeString(composite) + '.html'
end

def generateDirectoryStructure(composite)
  _compositeDir = compositeDir(composite)
  FileUtils.mkpath _compositeDir + $image_dir
  FileUtils.mkpath _compositeDir + $video_dir
  FileUtils.mkpath _compositeDir + $generated_images_dir

  FileUtils.mkpath revealjsOutDir(composite)
end

def copyResources(sourceDir, destDir)
  FileUtils.mkpath destDir
  FileUtils.copy_entry "#{sourceDir + $image_dir}", destDir
  FileUtils.copy_entry "#{sourceDir + $video_dir}", destDir
  FileUtils.copy_entry "#{sourceDir + $generated_images_dir}", destDir
end

def indexFile(composite)
  return compositeDir(composite) + '/index.adoc'
end

def customAttributesFor(composite)
  _compositeDir = compositeDir(composite)
  custom_attributes_comp = ''
  custom_attributes_comp += $custom_attributes
  custom_attributes_comp += " imagesoutdir=#{_compositeDir}/#{$generated_images_dir}"
  
  custom_attributes_comp += " java-dir=#{_compositeDir}#{$java_dir}"
  custom_attributes_comp += " kotlin-dir=#{_compositeDir}#{$kotlin_dir}"
  custom_attributes_comp += " js-dir=#{_compositeDir}#{$js_dir}"
  custom_attributes_comp += " plant-dir=#{_compositeDir}#{$plant_dir}"

  return custom_attributes_comp
end
