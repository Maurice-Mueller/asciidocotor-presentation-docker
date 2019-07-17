require './common'

#DEFAULT PROJECT SETTINGS
$theme = 'beige'

# DIRECTORIES
$root = '/asciip'
$src_base = $root + '/src'
$resources_base = $src_base + '/resources'
$doc_dir = $src_base + '/asciidoc'
$components_dir = $doc_dir + '/parts'
$composites_dir = $doc_dir + '/presentations'
$video_dir = $resources_base + '/videos'
$image_dir = $resources_base + '/images'
$plant_dir = $resources_base + '/plantuml'
$generated_images_dir = $resources_base + '/generated'
$pdf_images_dir = $resources_base + '/pdf_images_dir'
$out_dir = $root + '/out'
$revealjs_out_dir = '/revealjs'
$html_out_dir = '/html'
$asciidoc_pdf_out_dir = '/pdf'
$slides_pdf_out_dir =  '/slides-pdf'
$cordova_out_dir = '/cordova'
$custom_config_dir = $resources_base + '/custom_config'

# SETTINGS
$custom_attributes = ''
$custom_attributes += " imagesoutdir=#{$generated_images_dir}"
#$custom_attributes += " author=#{escapeString($author)}"
#$custom_attributes += " email=#{escapeString($email)}"
#$custom_attributes += " project_name=#{escapeString($project_name)}"
#$custom_attributes += " project_version=#{escapeString($project_version)}"
$custom_attributes += " comp=#{escapeString($components_dir)}"

# CODE
# To add a custom language, use the following pattern:
# $custom_attributes += " java=#{Dir.pwd}/src/java"
# and access it like {java} in your .adoc files.

$custom_attributes += " java-src=#{$src_base}/java"
$custom_attributes += " kotlin-src=#{$src_base}/kotlin"
$custom_attributes += " js-src=#{$src_base}/javascript"
$custom_attributes += " plant-dir=#{$src_base}/resources/plantuml "

# you can use highlight.js, coderay or pygments
$custom_attributes += ' source-highlighter=coderay'


# CORDOVA
# you only need those settings if you want to build an android or iOS app
$cordova_platforms = ['android']

# MISC
#$project_name_escaped = escapeString($project_name)
