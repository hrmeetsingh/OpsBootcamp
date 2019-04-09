FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y python3
RUN apt-get install -y openssh-server
RUN echo 'root:root' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

EXPOSE 8080
EXPOSE 22

CMD service ssh start && /bin/bash
