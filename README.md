# asciidoctor-presentation-docker

This is the repo for the Dockerfile of *Asciidoctor Presentation*.

To use this image run:

````
docker run -v $PWD:/presentations --user $(id -u):$(id -g) mauricemueller/asciidoc-presentation build-all
````

## Dev section

* build image
  ````
  docker build . -t mauricemueller/asciidoc-presentation:latest
  ````
* push image
  ````
  docker push mauricemueller/asciidoc-presentation:latest
  ````

