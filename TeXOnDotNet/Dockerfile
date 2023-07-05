# syntax=docker/dockerfile:1.3-labs
FROM mcr.microsoft.com/dotnet/aspnet:7.0

ENV LC_ALL=C.UTF-8
ENV TEXLIVE_INSTALL_NO_CONTEXT_CACHE=1
ENV NOPERLDOC=1
ENV TLHISTMIRRORURL='rsync://texlive.info/historic/systems/texlive'
ENV TLMIRRORURL='http://dante.ctan.org/tex-archive/systems/texlive/tlnet'
ENV DEBIAN_FRONTEND='noninteractive'

RUN apt-get update -y
RUN apt-get install apt-utils -y
RUN apt-get install wget -y
RUN apt-get install lsb-release -y

# Add "contrib" package to sources list for installing mscore fonts package (needed for Times New Roman)
RUN RELEASE_CODENAME=$(lsb_release -sc) && echo "deb http://deb.debian.org/debian ${RELEASE_CODENAME} contrib" >> /etc/apt/sources.list

RUN apt-get update -y
RUN apt-get install ttf-mscorefonts-installer -y

# Required library for running XeLaTeX
RUN apt-get install libfontconfig1 -y

# For installing PERL's modules
RUN apt-get install cpanminus -y 

# Install a missing module used by texlive installation script
RUN cpanm Pod::Usage --force

# Install TeXLive, the APT package is old (2020) and hasn't been updated
RUN mkdir tmp_tex
WORKDIR tmp_tex
COPY create-texlive-profile.sh .

RUN wget --quiet -O install.tar.gz https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
RUN tar -xzf install.tar.gz 
RUN rm install.tar.gz
RUN mv install-* install

# Create TeXLive installation profile, directly copying the file is causing issues in file encodings between Windows and Unix
RUN chmod +x create-texlive-profile.sh
RUN ./create-texlive-profile.sh
RUN install/install-tl -no-persistent-downloads -no-interaction -no-gui -profile texlive.profile

#### Initialise TeX ####
RUN tlmgr init-usertree
RUN tlmgr update --all

# Delete the temp file
RUN cd / && rm -rf tmp_tex
