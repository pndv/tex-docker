FROM fedora:latest

ENV LC_ALL=C.UTF-8
ENV TEXLIVE_INSTALL_NO_CONTEXT_CACHE=1
ENV NOPERLDOC=1
ENV TLHISTMIRRORURL=rsync://texlive.info/historic/systems/texlive
ENV TLMIRRORURL=http://dante.ctan.org/tex-archive/systems/texlive/tlnet

RUN dnf -y update && dnf -y upgrade
RUN dnf install git -y
RUN dnf install zip -y
RUN dnf install wget -y
RUN dnf install make -y
RUN dnf install -y rsync
RUN dnf install -y gnupg2
RUN dnf install -y fontconfig
RUN dnf install -y perl
RUN dnf install -y java-11-openjdk
RUN dnf install -y ncurses
RUN dnf install -y python3
RUN dnf install -y python3-pygments
RUN dnf install -y libnsl
RUN dnf install -y libnsl2

RUN mkdir -p tex
WORKDIR /tex
COPY texlive.profile .
RUN wget --quiet -O install.tar.gz https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
RUN tar -xvzf install.tar.gz
RUN rm *.tar.gz
RUN mv install-* install
RUN echo "PATH=/usr/local/texlive/2021/bin/x86_64-linux:$PATH" >> ~/.bashrc

RUN install/install-tl -no-persistent-downloads -no-gui -profile texlive.profile
RUN mkdir -p /opt/work

WORKDIR /opt/work

