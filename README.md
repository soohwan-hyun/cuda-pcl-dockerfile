# cuda-pcl-dockerfile

nvidia-cuda 9.0 && ubuntu 16.04

openssh-server libgdal * libgeotiff-dev libeigen3-dev libflann-dev libvtk5-dev libboost-all-dev PDAL 1.8.0 pcl 1.9.1 ...

it's just easily to use geospatial libraries...

i recommended this command to run this container:: sudo nvidia-docker run -it -d -p "22:22" --name cuda-pcl -v /home/$USER/volume/pcl:/dockervolume shhyun/cuda-pcl:latest

default ssh login password: pcl_test

It's written in Dockerfile at https://github.com/soohwan-hyun/cuda-pcl-dockerfile/blob/master/Dockerfile
