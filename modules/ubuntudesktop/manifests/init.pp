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
      ,"inkscape"
      ,"ubuntu-restricted-extras"
      ,"build-essential"
      ,"nautilus-dropbox"
      ,"shutter"
      ,"kazam"
    ]:
    ensure => present
  }
}
