Debian Jessie image with GDAL installed.  Used as a base image for various geospatial use cases, such as [https://github.com/pedros007/debian-mapserver](debian-mapserver)

This Docker Image is available on Dockerhub at [debian-gdal](https://hub.docker.com/r/pedros007/debian-gdal)

# Usage

Run gdalinfo on a file at `$(pwd)/file.tif` with this image:

	docker run --rm -it -v $(pwd):/data pedros007/debian-gdal:2.1.3 gdalinfo /data/file.tif

# Build

	docker build -t pedros007/debian-gdal:2.1.3 .
