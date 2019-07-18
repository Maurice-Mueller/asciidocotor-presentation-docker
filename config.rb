require './common'

#DEFAULT PROJECT SETTINGS
$theme = 'beige'

# DIRECTORIES
$root_dir = '/presentations'
$resources_dir = '/resources'
$asciidoc_dir = '/asciidoc'
$video_dir = $resources_dir + '/videos'
$image_dir = $resources_dir + '/images'
$plant_dir = $resources_dir + '/plantuml'
$source_dir = '/source'
$java_dir = $source_dir + '/java'
$kotlin_dir = $source_dir + '/kotlin'
$js_dir = $source_dir + '/javascript'
$generated_images_dir = $resources_dir + '/generated'
$pdf_images_dir = $resources_dir + '/pdf_images_dir'
$out_dir = '/build'
$revealjs_out_dir = $out_dir + '/revealjs'
$html_out_dir = $out_dir + '/html'
$asciidoc_pdf_out_dir = $out_dir + '/pdf'
$slides_pdf_out_dir = $out_dir + '/pdf'

# SETTINGS
$custom_attributes = ''

# you can use highlight.js, coderay or pygments
$custom_attributes += ' source-highlighter=coderay'
