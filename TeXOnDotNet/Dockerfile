FROM mcr.microsoft.com/dotnet/aspnet:7.0

ENV LC_ALL=C.UTF-8
ENV TEXLIVE_INSTALL_NO_CONTEXT_CACHE=1
ENV NOPERLDOC=1
ENV TLHISTMIRRORURL=rsync://texlive.info/historic/systems/texlive
ENV TLMIRRORURL=http://dante.ctan.org/tex-archive/systems/texlive/tlnet

RUN apt update -y
RUN apt install apt-utils -y
RUN apt install wget -y

###########################################################################
# For installing PERL's modules
RUN apt install cpanminus -y 

# Install a missing module used by texlive installation script
RUN  cpanm Pod::Usage --force

# Install TeXLive, the APT package is old (2020) and hasn't been updated
RUN mkdir tmp_tex
WORKDIR tmp_tex
RUN wget --quiet -O install.tar.gz https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
RUN tar -xzf install.tar.gz 
RUN rm install.tar.gz
RUN mv install-* install

COPY texlive-profile .

RUN install/install-tl -no-persistent-downloads -no-interaction -no-gui -profile texlive-profile
##############################################################################

#### Initialise TeX ####
RUN tlmgr init-usertree
RUN tlmgr update --all
