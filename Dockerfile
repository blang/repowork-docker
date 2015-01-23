FROM ubuntu:trusty
MAINTAINER Benedikt Lang <mail@blang.io>
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -q

RUN apt-get install -qy wget curl vim

RUN apt-get install -qy openssh-server
RUN mkdir /var/run/sshd

RUN useradd -g users -d /home/repowork -s /bin/bash repowork

RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
RUN locale-gen

RUN apt-get install -qy zip unzip bzip2 gzip p7zip-full mc nano ftp ncftp

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]