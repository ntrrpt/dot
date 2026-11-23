## termux setup:
```bash
# packages
pkg up && pkg in \
   openssh ffmpeg uv tmux frp zsh byobu wget git fzf rust vim micro croc eza gdu mosh nmap rsync

# omz
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# cpp / tmux / .zshrc / .vimrc / omz plugins
mkdir ~/cpp && \
   wget -O ~/cpp/cpp.conf https://github.com/ntrrpt/dot/raw/refs/heads/main/cpp/cpp.conf && \
   wget -O ~/.tmux.conf https://github.com/ntrrpt/dot/raw/refs/heads/main/.tmux.conf && \
   wget -O ~/.zshrc https://github.com/ntrrpt/dot/raw/refs/heads/main/.zshrc && \
   wget -O ~/.privrc https://github.com/ntrrpt/dot/raw/refs/heads/main/.privrc && \
   git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime && sh ~/.vim_runtime/install_awesome_vimrc.sh && \
   git clone https://github.com/z-shell/F-Sy-H.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/F-Sy-H && \
   git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# uv tools
uv tool install "copyparty" --with "pyftpdlib,pillow,mutagen" && \
   uv tool install "yt-dlp[default]" && \
   uv tool install gallery-dl --with "yt-dlp[default],pysocks" && \
   uv tool install streamlink && \
   uv tool install internetarchive
```

## debian setup:
```bash
# packages / docker
sudo apt update && \
   sudo apt upgrade -y && \
   sudo apt install -y ca-certificates curl jq duf ffmpeg tmux zsh mc aria2 unrar-free 7zip unzip bat cron byobu btop htop pv mbuffer wget git fzf vim micro eza gdu mosh nmap rsync && \
   sudo install -m 0755 -d /etc/apt/keyrings && \
   sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc && \
   sudo chmod a+r /etc/apt/keyrings/docker.asc && \
   ( sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/debian
Suites: $(. /etc/os-release && echo "$VERSION_CODENAME")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF
) && \ 
   sudo apt update && \
   sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin && \
   sudo apt autoremove -y && \
   sudo apt clean

# omz
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# tmux / .zshrc / .vimrc / omz plugins
wget -O ~/.tmux.conf https://github.com/ntrrpt/dot/raw/refs/heads/main/.tmux.conf && \
   wget -O ~/.zshrc https://github.com/ntrrpt/dot/raw/refs/heads/main/.zshrc && \
   wget -O ~/.privrc https://github.com/ntrrpt/dot/raw/refs/heads/main/.privrc && \
   git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime && sh ~/.vim_runtime/install_awesome_vimrc.sh && \
   git clone https://github.com/z-shell/F-Sy-H.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/F-Sy-H && \
   git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
   byobu-enable && omz reload

# croc / uv tools
bash -c "$(curl -fsSL https://getcroc.com)" && \
   bash -c "$(curl -fsSL https://astral.sh/uv/install.sh)" && \
   uv tool install "copyparty[all]" --with "fusepy,pyvips[binary]" && \
   uv tool install "yt-dlp[default]" && \
   uv tool install gallery-dl --with "yt-dlp[default],pysocks" && \
   uv tool install streamlink && \
   uv tool install internetarchive

# swap
sudo fallocate -l 4G /swapfile && \
   sudo chmod 600 /swapfile && \
   sudo mkswap /swapfile && \
   sudo swapon /swapfile && \
   echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

# /etc/ssh/sshd_config
PasswordAuthentication no
Port 69420

# udphop
iptables-restore < rules.v4 && \
   ip6tables-restore < rules.v6

iptables-save > /etc/iptables/rules.v4 && \
   ip6tables-save > /etc/iptables/rules.v6
# or
sudo apt install iptables-persistent && \
   systemctl enable netfilter-persistent && \
   systemctl restart netfilter-persistent

# crontab (every 10 min)
*/10 * * * * /root/cron.sh

reboot
```

## basic systemd unit:
```bash
install meow /usr/local/bin

sudo tee /etc/systemd/system/meow.service <<EOF
[Unit]
Description=meow
After=network.target

[Service]
Type=simple
User=root
Environment="MEOW_ENV=uwu"
ExecStart=/usr/local/bin/meow --nya
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable --now meow.service
```












