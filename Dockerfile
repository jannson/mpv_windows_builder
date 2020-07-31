FROM ubuntu:bionic

ARG DEBIAN_FRONTEND=noninteractive

#COPY pip.conf /etc/pip.conf
#RUN mkdir /root/.pip
#COPY pip.conf /root/pip.conf
#COPY sources.list /etc/apt/sources.list

RUN rm -rf /var/lib/apt/lists/* && \
    chmod 777 /tmp && \
    rm -rf /etc/localtime && \
    ln -s /usr/share/zoneinfo/Asia/Harbin /etc/localtime && \
    echo "nameserver 114.114.114.114" > /etc/resolv.conf && \
    apt-get update && apt-get upgrade -y && \
    apt-get -y install --no-install-recommends openssh-server net-tools cron git tmux build-essential wget vim openssl unzip tar bzip2 curl psmisc libreadline-dev libncurses5-dev libpcre3-dev libssl-dev perl make locales zsh autojump sudo && \
    apt-get -y autoremove && apt-get clean && \
    sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen && \
    useradd -m xiaobao && \
    echo "xiaobao:xiaobao" | chpasswd && \
    echo "xiaobao ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/xiaobao && \
    mkdir -p /var/run/sshd && \
    sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config && \
    echo "Banner /home/.shell/ssh-banner" >> /etc/ssh/sshd_config && \
    echo "UseDNS no" >> /etc/ssh/sshd_config && \
    sed -i 's/#ListenAddress 0.0.0.0/ListenAddress 0.0.0.0/g' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config && \
    sed -i 's/PermitRootLogin .*/PermitRootLogin without-password/g' /etc/ssh/sshd_config && \
    echo "alias ls='ls --color=auto'" >> /root/.bashrc && \
    echo "alias ll='ls -lh'" >> /root/.bashrc && \
    echo "alias l='ls -lAh'" >> /root/.bashrc && \
    echo "alias wget='wget --no-check-certificate'" >> /root/.bashrc && \
    mkdir -p /root/.ssh/ && touch /root/.ssh/authorized_keys && \
    echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC8wuO/aLRg/a5z/i2AnaApGac69+yL8ohCYzF6yOxuvrU+E31Da4eQp6T3Kn2M51dzeAh0VcgAD20zzrcNcdqHvmzRDt6+o9FJJGOkwIHv1BNKhu84wfweJKO5OYwLxmuaUtH2uGCTM8/wzlozJLNnBWYHjlZftvDT7rkT517DWBXBBKTtnj7kstsEfxPfDtmTSiSR12T/PllOAFTMSqIM92yWiJZ0oImJABFF7nHMDu4uv7eFJ1whZLyYGgIT0gCevGWXuN5+wXKJoQK3P/Mi3aMIcu9LNoX/dT1wlLxeQYiut8aOD6XhOeubIP0IHNiyzyaErxz0/68/28cEF3z5 clang' > /root/.ssh/authorized_keys && \
    chmod 600 -R /root/.ssh/ && \
    echo "root:Xiaobao@2018" | chpasswd

RUN apt update && apt install -y coreutils python python3 autopoint bison flex gperf libtool ruby unzip p7zip-full libgdk-pixbuf2.0-dev intltool git vim make automake autoconf libtool-bin gcc-multilib g++-multilib wget lzip cmake yasm scons

#mkdir -p /opt && cd /opt && git clone https://github.com/mxe/mxe mxe && \
#    cd /opt/mxe && echo "MXE_TARGETS := x86_64-w64-mingw32.static" >> settings.mk && make -j`nproc` gcc ffmpeg libass jpeg lua libarchive && export PATH=$PWD/usr/bin:$PATH
#    cd /opt && git clone --depth=1 https://github.com/mpv-player/mpv.git mpv && cd /opt/mpv && python ./bootstrap.py && DEST_OS=win32 TARGET=x86_64-w64-mingw32.static ./waf configure && ./waf -j`nproc` build

#WORKDIR /opt/mxe
#CMD /bin/bash
