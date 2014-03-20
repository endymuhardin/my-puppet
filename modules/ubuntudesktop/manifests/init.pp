class ubuntudesktop {
    package { [
      "keepassx"
      ,"gedit-plugins"
      ,"fonts-inconsolata"
      ,"fonts-droid"
      ,"nautilus-open-terminal"
      ,"unrar"
      ,"gimp"
      ,"gimp-plugin-registry"
      ,"gtk-recordmydesktop"
      ,"network-manager-openvpn"
      ,"network-manager-openvpn-gnome"
      ,"network-manager-pptp"
      ,"network-manager-pptp-gnome"
      ,"network-manager-vpnc"
      ,"network-manager-vpnc-gnome"
      ,"inkscape"
      ,"ubuntu-restricted-extras"
      ,"build-essential"
      ,"nautilus-dropbox"
      ,"chromium-browser"
      ,"shutter"
      ,"skype"
    ]:
    ensure => present
  }
}
