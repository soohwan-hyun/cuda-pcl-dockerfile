FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04
MAINTAINER shhyun

RUN apt-get update
RUN apt-get upgrade -y
RUN echo 'root:pcl_test' | chpasswd
RUN apt-get install -y openssh-server vim net-tools wget
RUN mkdir /var/run/sshd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

RUN apt-get update -y --fix-missing && apt-get install -y libvtk5-dev
RUN apt-get update -y --fix-missing && apt-get install -y libgdal-* libgeotiff-dev
RUN apt-get update -y --fix-missing && apt-get install -y libeigen3-dev libflann-dev
RUN apt-get update -y --fix-missing && apt-get install -y libboost-all-dev
RUN apt-get install -y git build-essential cmake gdb
RUN apt-get install -y liblas-dev
RUN git clone https://github.com/PDAL/PDAL.git --branch 1.8.0 /root/pdal
RUN cd /root/pdal && mkdir build && cd build && cmake ../ && make -j 16 && make install && cd /

RUN git clone https://github.com/PointCloudLibrary/pcl --branch pcl-1.9.1 /root/pcl
RUN cd /root/pcl && mkdir build && cd build && cmake ../ -DBUILD_CUDA=ON -DBUILD_GPU=ON && make -j 16 && make install && cd /

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
