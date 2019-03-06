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

RUN apt-get update -y && apt-get install -y libgdal-* libgeotiff-dev
RUN apt-get install -y git build-essential cmake
RUN git clone https://github.com/PDAL/PDAL.git --branch 1.8.0 /root/pdal
RUN cd /root/pdal && mkdir build && cd build && cmake ../ && make -j 5 && make install

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
