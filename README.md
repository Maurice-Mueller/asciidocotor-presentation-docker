# asciidoctor-presentation-docker

This is the repo for the Dockerfile of *Asciidoctor Presentation*.


Quick start:
````
docker run -v $PWD:/presentations --user $(id -u):$(id -g) mauricemueller/asciidoc-presentation build
````

## How to use

This service expects a directory structure as in the following:

````
|-- ROOT
    |-- Presentation_1
        |-- index.adoc
    |-- Presentation_2
        |-- index.adoc
````

The `index.adoc` file is the entry point for the asciidoctor engine. You need to provide this.


### Special folders

Some folders have special meaning and can be accessed in a special way in your asciidoc file:

````
    |-- Presentation
        |-- index.adoc
        |-- resources (optional)
            |-- images 
            |-- videos
        |-- source (optional)
            |-- java
````

Then you can easily access the images like this:

`image::image_from_images_folder.jpg[]`

Or access java source code like this: `include::{java-dir}/subfolder/code.java[]`


### Commands

* `<command> [presentation]`
  * `<command>` = build command
  * `[presentation]` optional = choose the presentation by its folder name; if empty all presentations will be build

| command          | target |
|------------------|---------------------------------------|
| build            | revealjs                       |
| build-pdf        | pdf with continuous text     |
| build-pdf-slides | pdf in slide form            |
| build-html       | website with continuous text |
| build-all        | all targets                    |


## Dev section

* build image
  ````
  docker build . -t mauricemueller/asciidoc-presentation:latest
  ````
* push image
  ````
  docker push mauricemueller/asciidoc-presentation:latest
  ````

