FROM kalilinux/kali-rolling

RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -y kali-linux-headless 

RUN apt update && apt install -y \
    kali-defaults \
    kali-tools-web \
    kali-desktop-xfce \
    x11vnc \
    xvfb \
    novnc \
    dbus-x11 \
    tigervnc-standalone-server 

RUN apt update && apt install -y \
    neovim \
    htop \
    fish \
    inetutils-ping

# VPN用のディレクトリを作成
RUN mkdir -p /dev/net && mknod /dev/net/tun c 10 200 && chmod 600 /dev/net/tun

# 環境変数の設定
ENV DISPLAY=:1

# ユーザーの追加
RUN useradd -m -s /bin/bash kali && \
    echo "kali:kali" | chpasswd && \
    usermod -aG sudo kali

# ユーザーの切り替え
USER kali

# ユーザーのホームディレクトリに移動
WORKDIR /home/kali