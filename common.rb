require 'rubygems'

def escapeString(s)
  s.gsub(/ /, '\ ')
end

def cordovaWorkingDir(composite)
  "#{$out_dir}/#{composite}/#{$cordova_out_dir}"
end

def revealJSWorkingDir(composite)
  return $out_dir + '/' + composite + $revealjs_out_dir
end

def revealJSOutFile(composite)
  return revealJSWorkingDir(composite) + '/' + composite + '.html'
end

def indexFile(composite)
  return "#{$composites_dir}/#{composite}/index.adoc"
end
