{ config, pkgs, ... }:

let
    systemApps = with pkgs; [
      nitrogen
      alacritty
      dmenu
      git
      gnome-keyring
      networkmanagerapplet
      pasystray
      picom
      polkit_gnome
      pulseaudioFull
      # rofi
      vim
      unrar
      unzip
      lxappearance-gtk2
      pywal
      autotiling
      # xss-lock
      xfce.xfce4-screenshooter
      betterlockscreen
      bluez-tools
      blueman
      inotify-tools
      brightnessctl
      xidlehook
      xautolock
      python314
      gsettings-desktop-schemas
      dconf-editor
      # polybar
      killall
      zlib
      htop
      neofetch
      arandr
      pa_applet
      xarchiver
    ];

    userApps = with pkgs; [
      motrix
      # asusctl
      gparted
      (nerdfonts.override { fonts = [ "Hack" ]; })
      brave
      mendeley
      vscodium-fhs
      joplin-desktop
      dropbox
      conda
      xscreensaver
    ];

    appendApps = apps: systemApps ++ userApps ++ apps;
    
in{
    home.username = "super";
    home.homeDirectory = "/home/super";

    home.stateVersion = "24.11";
    
    home.packages = with pkgs; appendApps[];

    home.file = {
      ".config/i3status".source = ~/.homedots/i3status;
      ".config/i3".source = ~/.homedots/i3;
      ".config/alacritty".source = ~/.homedots/alacritty;
      ".profile".source = ~/.homedots/.profile;
    };

    home.sessionVariables = {
      # EDITOR = "emacs";
    };

    programs.git = {
      enable = true;
      userEmail = "adhavneeraj9500@gmail.com";
      userName = "neerajadhav";
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
    nixpkgs = {
      config = {
        allowUnfree = true;
      };
    };
}
