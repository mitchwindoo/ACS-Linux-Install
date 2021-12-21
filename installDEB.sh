#!/bin/sh
# Deb Installer files
cd ~/Downloads
echo "Downloading VS Code"
wget https://az764295.vo.msecnd.net/stable/ccbaa2d27e38e5afa3e5c21c1c7bef4657064247/code_1.62.3-1637137107_amd64.deb
echo "Downloading Google Chrome"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
echo "Downloading 1Password"
wget https://downloads.1password.com/linux/debian/amd64/stable/1password-latest.deb
echo "Installing Packages"
sudo dpkg -i *.deb
echo "Repairing dependencies with 1Password Installation"
sudo apt --fix-broken install

# Blacklist nouveau drivers
echo "Blacklisting the open source nouveau drivers for Nvidia Graphics cards"
sudo bash -c "echo blacklist nouveau > /etc/modprobe.d/blacklist-nvidia-nouveau.conf" 
sudo bash -c "echo options nouveau modeset=0 >> /etc/modprobe.d/blacklist-nvidia-nouveau.conf" 
cat /etc/modprobe.d/blacklist-nvidia-nouveau.conf 

# Add repositories
echo "Adding software sources to be able to install all the software"
sudo add-apt-repository -y multiverse 
sudo add-apt-repository -y ppa:agornostal/ulauncher 
sudo add-apt-repository -y ppa:linrunner/tlp 
sudo add-apt-repository -y ppa:teejee2008/ppa 
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo apt install apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo curl https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo apt-key add 
sudo sh -c 'echo "deb https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list' 

# Make sure the system is up to date
echo "Updating the package system and installing any available updates prior to software install"
sudo apt update && sudo apt upgrade
echo "Installing new software for VM Management, Nvidia drivers, and other system utilities"
sudo apt install node-typescript make git gnome-tweaks gnome-shell-extensions network-manager-openvpn-gnome ulauncher tlp tlp-rdw gnome-user-share samba conky-all qemu qemu-kvm libvirt-daemon libvirt-clients bridge-utils virt-manager timeshift snapd sublime-text nvidia-driver-495 discord pgadmin4-desktop fish neofetch zsh chrome-gnome-shell ubuntu-restricted-extras unzip p7zip unrar unattended-upgrades
flatpak install flathub io.github.celluloid_player.Celluloid 

# Install RDP Client
echo "Installing Remmina for Remote Desktop (RDP) Support"
flatpak install org.freedesktop.Platform
flatpak install org.freedesktop.Platform.openh264
flatpak install --user flathub org.remmina.Remmina
flatpak run --user org.remmina.Remmina

# Make Directory to place theme files
echo "Creating directories for user themes"
mkdir ~/.themes 
mkdir ~/.icons 

# Finish script and run neofetch
echo "Packages are done installing"
neofetch