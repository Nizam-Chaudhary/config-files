#! /bin/bash

echo 'DNS=Cloudflare: 1.1.1.1#cloudflare-dns.com 1.0.0.1#cloudflare-dns.com 2606:4700:4700::1111#cloudflare-dns.com 2606:4700:4700::1001#cloudflare-dns.com' | sudo tee -a /etc/systemd/resolved.conf
echo 'FallbackDNS=8.8.8.8#dns.google 8.8.4.4#dns.google 2001:4860:4860::8888#dns.google 2001:4860:4860::8844#dns.google' | sudo tee -a /etc/systemd/resolved.conf
echo 'DNSOverTLS=yes' | sudo tee -a /etc/systemd/resolved.conf

sudo systemctl restart systemd-resolved.service

echo '*************************************************************************'
echo '--------------------------Updating System--------------------------'
echo '*************************************************************************'
sudo apt update

echo '*************************************************************************'
echo '--------------------------Installing Nala--------------------------'
echo '*************************************************************************'
sudo apt install nala -y


echo '*************************************************************************'
echo '--------------------------Upgrading System--------------------------'
echo '*************************************************************************'
sudo apt upgrade -y

echo '*************************************************************************'
echo '--------------------------Installing Softwares--------------------------'
echo '*************************************************************************'
sudo nala install zsh kitty tldr exa vim git wget curl flatpak unzip gnome-tweaks   -y

cd ~/

sudo nala install stow -y

echo '*************************************************************************'
echo '--------------------------Cloning Repos--------------------------'
echo '*************************************************************************'
git clone https://github.com/Nizam-Chaudhary/config-files.git ~/config-files
git clone https://github.com/Nizam-Chaudhary/wallpapers.git ~/Pictures/wallpapers
chmod +x ~/config-files/download.sh 
sudo ln -sf ~/config-files/download.sh /usr/local/bin/download

echo '*************************************************************************'
echo '--------------------------changing default shell to zsh--------------------------'
echo '*************************************************************************'
sudo chsh -s /usr/bin/zsh


echo '*************************************************************************'
echo '--------------------------Installing aria2--------------------------'
echo '*************************************************************************'
sudo nala install aria2 -y

cd ~/Downloads

echo '*************************************************************************'
echo '--------------------------Downloading chrome and vscode--------------------------'
echo '*************************************************************************'
aria2c -o google-chrome.deb --file-allocation=none -c -j 10 -x 10 https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

aria2c -o vscode.deb --file-allocation=none -c -j 10 -x 10 https://vscode.download.prss.microsoft.com/dbazure/download/stable/384ff7382de624fb94dbaf6da11977bba1ecd427/code_1.94.2-1728494015_amd64.deb

echo '*************************************************************************'
echo '--------------------------Installing chrome and vscode--------------------------'
echo '*************************************************************************'
sudo nala install ./google-chrome.deb ./vscode.deb -y

rm google-chrome.deb vscode.deb

echo '*************************************************************************'
echo '--------------------------Installing JetBrains Nerd Font--------------------------'
echo '*************************************************************************'
# JetBrains Nerd Font
mkdir ~/.local/share/fonts

aria2c -o Jetbrains.zip --file-allocation=none -c -j 10 -x 10 https://objects.githubusercontent.com/github-production-release-asset-2e65be/27574418/c73b35fc-92bd-4850-a79a-ccb86b8069c9?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=releaseassetproduction%2F20241027%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20241027T082712Z&X-Amz-Expires=300&X-Amz-Signature=e64ec6153ef93e53525a6cb556c0227c0a8ed7de8861cb8cd616505582ec8e2e&X-Amz-SignedHeaders=host&response-content-disposition=attachment%3B%20filename%3DJetBrainsMono.zip&response-content-type=application%2Foctet-stream

unzip ~/Downloads/Jetbrains.zip -d ~/Downloads/JetBrainsMono

mv ~/Downloads/JetBrainsMono ~/.local/share/fonts

rm Jetbrains.zip

echo '*************************************************************************'
echo '--------------------------Installing Starship prompt--------------------------'
echo '*************************************************************************'
# starship prompt
curl -sS https://starship.rs/install.sh | sh

echo '*************************************************************************'
echo '--------------------------Restoring Config files--------------------------'
echo '*************************************************************************'
cd ~/config-files

stow git nvim kitty starship

echo '*************************************************************************'
echo '--------------------------Installing oh my bash--------------------------'
echo '*************************************************************************'

# oh my bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
sudo nala install -y haskell-stack

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# oh my zsh
echo '*************************************************************************'
echo '--------------------------Installing oh my zsh--------------------------'
echo '*************************************************************************'
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

cd ~/

rm ~/.bashrc  ~/.zshrc

cd ~/config-files

stow zshrc bashrc

