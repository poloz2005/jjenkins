#
# Super simple example of a Dockerfile
#
FROM ubuntu:latest

RUN apt-get update
RUN apt-get install -y  wget


WORKDIR /home
