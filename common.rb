require 'rubygems'

def escapeString(s)
  s.gsub(/ /, '\ ')
end

def revealJSWorkingDir(composite)
  return escapeString($root_dir + '/' + composite + $revealjs_out_dir)
end

def revealJSOutFile(composite)
  return revealJSWorkingDir(composite) + '/' + escapeString(composite) + '.html'
end

def indexFile(composite)
  return escapeString("#{$root_dir + '/' + composite}/index.adoc")
end

def customAttributesFor(composite)
  compositeDir = escapeString($root_dir + '/' + composite)
  custom_attributes_comp = ''
  custom_attributes_comp += $custom_attributes
  custom_attributes_comp += " imagesoutdir=#{compositeDir}/#{$generated_images_dir}"
  
  custom_attributes_comp += " java-dir=#{compositeDir}#{$java_dir}"
  custom_attributes_comp += " kotlin-dir=#{compositeDir}#{$kotlin_dir}"
  custom_attributes_comp += " js-dir=#{compositeDir}#{$js_dir}"
  custom_attributes_comp += " plant-dir=#{compositeDir}#{$plant_dir}"

  return custom_attributes_comp
end
