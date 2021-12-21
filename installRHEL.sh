#!/bin/sh
# Add Repositories and install updates
echo "First, we will install any neccessary repositories and install available system updates"
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo rpm --import https://downloads.1password.com/linux/keys/1password.asc
sudo sh -c 'echo -e "[1password]\nname=1Password Stable Channel\nbaseurl=https://downloads.1password.com/linux/rpm/stable/\$basearch\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=\"https://downloads.1password.com/linux/keys/1password.asc\"" > /etc/yum.repos.d/1password.repo'

dnf check-update
sudo dnf upgrade

echo "Installing Essential Utilities"
sudo dnf install -y gnome-tweaks make git ulauncher tlp tlp-rdw gnome-user-share samba timeshift fish neofetch zsh unzip p7zip akmod-nvidia 1password code
echo "Installing Virtualization Application and Libraries"
sudo dnf group install -y --with-optional virtualization

# Finish script and run neofetch
echo "Packages are done installing"
neofetch