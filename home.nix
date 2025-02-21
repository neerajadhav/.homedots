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
      vim
      unrar
      unzip
      lxappearance-gtk2
      libnotify
      pywal
      autotiling
      nodejs_22
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
      killall
      htop
      neofetch
      arandr
      pa_applet
      xarchiver
      dunst
    ];

    userApps = with pkgs; [
      motrix
      gparted
      (nerdfonts.override { fonts = [ "Hack" ]; })
      brave
      mendeley
      vscodium-fhs
      joplin-desktop
      dropbox
      conda
      xscreensaver
      vlc
      onlyoffice-desktopeditors
      xfce.ristretto
    ];

    appendApps = apps: systemApps ++ userApps ++ apps;
    
in{
    home.username = "super";
    home.homeDirectory = "/home/super";

    home.stateVersion = "24.11";
    
    home.packages = with pkgs; appendApps[];

    home.file = {
      ".config/i3status".source = ~/.homedots/i3status;
      ".config/i3pystatus".source = ~/.homedots/i3pystatus;
      ".config/i3blocks".source = ~/.homedots/i3blocks;
      ".config/i3".source = ~/.homedots/i3;
      ".config/picom".source = ~/.homedots/picom;
      ".config/alacritty".source = ~/.homedots/alacritty;
      ".profile".source = ~/.homedots/.profile;
      ".bashrc".source = ~/.homedots/.bashrc;
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

    dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };
}
