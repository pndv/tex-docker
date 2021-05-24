from fedora:latest

ENV LC_ALL=C.UTF-8
ENV TEXLIVE_INSTALL_NO_CONTEXT_CACHE=1
ENV NOPERLDOC=1
ENV TLHISTMIRRORURL=rsync://texlive.info/historic/systems/texlive
ENV TLMIRRORURL=http://dante.ctan.org/tex-archive/systems/texlive/tlnet

run dnf -y update && dnf -y upgrade 
run dnf install git -y
run dnf install zip -y
run dnf install wget -y
run dnf install make -y 
run dnf install -y rsync
run dnf install -y gnupg2
run dnf install -y fontconfig
run dnf install -y perl
run dnf install -y java-11-openjdk
run dnf install -y ncurses
run dnf install -y python3
run dnf install -y python3-pygments
run dnf install -y libnsl
run dnf install -y libnsl2

run mkdir -p tex
workdir /tex 
copy texlive.profile .
run wget --quiet -O install.tar.gz https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
run tar -xvzf install.tar.gz
run rm *.tar.gz
run mv install-* install
run echo "PATH=/usr/local/texlive/2021/bin/x86_64-linux:$PATH" >> ~/.bashrc

run install/install-tl -no-persistent-downloads -no-gui -profile texlive.profile
run mkdir -p /opt/work

workdir /opt/work

