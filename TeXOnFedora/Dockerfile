FROM fedora:latest

ENV LC_ALL=C.UTF-8
ENV TEXLIVE_INSTALL_NO_CONTEXT_CACHE=1
ENV NOPERLDOC=1
ENV TLHISTMIRRORURL='rsync://texlive.info/historic/systems/texlive'
ENV TLMIRRORURL='http://dante.ctan.org/tex-archive/systems/texlive/tlnet'

RUN dnf -y update && dnf -y upgrade

# Install required packages
RUN dnf install wget -y
RUN dnf install perl -y

# Get TeXLive installation package
RUN mkdir -p tex
WORKDIR /tex

# Create TeXLive installation profile, directly copying the file is causing issues in file encodings between Windows and Unix
COPY create-texlive-profile.sh .
RUN chmod +x create-texlive-profile.sh
RUN ./create-texlive-profile.sh

RUN wget --quiet -O install.tar.gz https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
RUN tar -xvzf install.tar.gz
RUN rm *.tar.gz
RUN mv install-* install

# Run TeXLive installation
RUN install/install-tl -no-persistent-downloads -no-gui -profile texlive.profile

# Add to environment path
RUN echo "PATH=/usr/local/texlive/2021/bin/x86_64-linux:$PATH" >> ~/.bashrc

# Initialise TeXLive
RUN /usr/local/texlive/2021/bin/x86_64-linux/tlmgr init-usertree
RUN /usr/local/texlive/2021/bin/x86_64-linux/tlmgr update --all

RUN mkdir -p /opt/work
WORKDIR /opt/work

# Delete the temporary files
RUN rm -rf /tex
