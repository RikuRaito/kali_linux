FROM kalilinux/kali-rolling

# 必要最小限のパッケージ + TryHackMe初心者向けツール
RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -y \
    kali-defaults \
    sudo \
    neovim \
    htop \
    fish \
    inetutils-ping \
    # ネットワークスキャン・偵察
    nmap \
    gobuster \
    nikto \
    enum4linux \
    smbclient \
    # ブルートフォース・パスワードクラック
    hydra \
    john \
    wordlists \
    # Web関連
    curl \
    wget \
    # ネットワークツール
    netcat-traditional \
    openvpn \
    # 開発ツール
    git \
    python3 \
    python3-pip \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

# rockyou.txtを解凍（よく使うワードリスト）
RUN gunzip -f /usr/share/wordlists/rockyou.txt.gz 2>/dev/null || true

# VPN用のディレクトリを作成
RUN mkdir -p /dev/net && mknod /dev/net/tun c 10 200 && chmod 600 /dev/net/tun

# ユーザーの追加
RUN useradd -m -s /bin/bash kali && \
    echo "kali:kali" | chpasswd && \
    usermod -aG sudo kali

# ユーザーの切り替え
USER kali

# ユーザーのホームディレクトリに移動
WORKDIR /home/kali