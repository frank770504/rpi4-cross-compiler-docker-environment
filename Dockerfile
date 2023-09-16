# syntax=docker/dockerfile:1-labs
FROM ubuntu:22.04
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update

# chroots setting
RUN apt-get install wget -y
RUN ln -fs /usr/share/zoneinfo/Asia/Taipei /etc/localtime
RUn apt-get install tzdata -y
RUN apt-get install ubuntu-dev-tools cmake curl -y
RUN apt-get install -y \
                    pkg-config \
                    libglib2.0-dev \
                    libgtk2.0-dev \
                    libtool \
                    g++
RUN apt-get install git -y
RUN apt-get install vim -y
RUN apt-get install libboost-all-dev -y
RUN apt-get install zip -y
RUN apt-get install gdb -y
RUN apt-get install ssh -y
RUN apt-get install -y gcc g++ gperf bison flex texinfo help2man make libncurses5-dev \
    python3-dev autoconf automake libtool libtool-bin gawk wget bzip2 xz-utils unzip \
    patch libstdc++6 rsync git meson ninja-build
RUN apt-get install -y apt-utils autodep8 autopkgtest \
    libemail-date-format-perl libfilesys-df-perl libmime-lite-perl \
    libmime-types-perl libsbuild-perl schroot-common deborphan kmod sbuild
RUN curl -sL https://ftp-master.debian.org/keys/release-11.asc | gpg --import -
RUN gpg --export 605C66F00D6C9793 > $HOME/raspbian-archive-keyring.gpg
RUN <<EOF cat >> $HOME/rpi.sources
deb http://deb.debian.org/debian bullseye main contrib non-free
deb http://security.debian.org/debian-security bullseye-security main contrib non-free
deb http://deb.debian.org/debian bullseye-updates main contrib non-free
deb http://archive.raspberrypi.org/debian/ bullseye main
# Uncomment deb-src lines below then 'apt-get update' to enable 'apt-get source'
#deb-src http://deb.debian.org/debian bullseye main contrib non-free
#deb-src http://security.debian.org/debian-security bullseye-security main contrib non-free
#deb-src http://deb.debian.org/debian bullseye-updates main contrib non-free
EOF
RUN <<EOF cat >> $HOME/.mk-sbuild.rc
SOURCE_CHROOTS_DIR="$HOME/sys/chroots"
DEBOOTSTRAP_KEYRING="$HOME/raspbian-archive-keyring.gpg"
TEMPLATE_SOURCES="$HOME/rpi.sources"
SKIP_UPDATES="1"
SKIP_PROPOSED="1"
SKIP_SECURITY="1"
EATMYDATA="1"
EOF

# build chroots
RUN usermod -a -G sbuild root
RUN newgrp sbuild
ENV ARCH=arm64
ENV RELEASE=bullseye
ENV TC=aarch64-rpi4-linux-gnu
RUN --security=insecure mk-sbuild --arch=$ARCH $RELEASE \
    --debootstrap-mirror=http://deb.debian.org/debian/ \
    --name=rpi-$RELEASE
RUN --security=insecure sbuild-apt rpi-$RELEASE-$ARCH apt-get install curl
RUN --security=insecure echo "curl -sL http://archive.raspberrypi.org/debian/raspberrypi.gpg.key | gpg --import -" | sbuild-shell rpi-$RELEASE-$ARCH
RUN --security=insecure echo "gpg -a --export 82B129927FA3303E | apt-key add -" | sbuild-shell rpi-$RELEASE-$ARCH
RUN --security=insecure sbuild-apt rpi-$RELEASE-$ARCH apt-get update
COPY ./entrypoint.sh /entrypoint.sh

# vim environment setting
RUN git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
COPY vimrc /root/.vimrc
RUN vim +PluginInstall +qall
RUN apt-get install universal-ctags -y
RUN apt-get install fonts-powerline -y
RUN apt-get install ripgrep -y
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install --key-bindings --completion --update-rc
RUN apt-get install vim-nox mono-complete golang nodejs openjdk-17-jdk openjdk-17-jre npm -y
RUN cd ~/.vim/bundle/YouCompleteMe && ./install.py --all --force-sudo
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
