FROM python:2
MAINTAINER Peter Schmitt "pschmitt@gmail.com"

# To build from a release:
#curl http://download.osgeo.org/gdal/2.2.1/gdal-2.2.1.tar.gz | tar zxv -C /tmp && \
#cd /tmp/gdal-2.2.1 && \
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y \
    build-essential make curl ca-certificates libcurl4-gnutls-dev \
    shapelib libproj-dev libproj0 proj-data libgeos-3.4.2 libgeos-c1 libgeos-dev \
    postgresql-client-common libpq-dev \
    -y --no-install-recommends && \
    curl -L https://github.com/uclouvain/openjpeg/releases/download/v2.2.0/openjpeg-v2.2.0-linux-x86_64.tar.gz | tar zxv --strip-components=1 -C /usr && \
    pip install numpy && \
    svn co https://svn.osgeo.org/gdal/trunk/gdal /tmp/gdal-trunk && \
    cd /tmp/gdal-trunk && \
    ./configure \
    --prefix=/usr \
    --with-threads \
    --with-hide-internal-symbols=yes \
    --with-rename-internal-libtiff-symbols=yes \
    --with-rename-internal-libgeotiff-symbols=yes \
    --with-libtiff=internal \
    --with-geotiff=internal \
    --with-geos \
    --with-pg \
    --with-curl \
    --with-static-proj4=yes \
    --with-openjpeg=yes \
    --with-ecw=no \
    --with-grass=no \
    --with-hdf5=no \
    --with-java=no \
    --with-mrsid=no \
    --with-perl=no \
    --with-python=yes \
    --with-webp=no \
    --with-xerces=no && \
    make -j $(grep --count ^processor /proc/cpuinfo) && \
    make install && \
    apt-get remove --purge -y libcurl4-gnutls-dev libproj-dev libgeos-dev libpq-dev && \
    rm -rf /var/lib/apt/lists/* /tmp/*

# Set HOME dir so AWS credentials can be fetched at ~/.aws/credentials
# https://lists.osgeo.org/pipermail/gdal-dev/2017-July/046846.html
ENV HOME /root
