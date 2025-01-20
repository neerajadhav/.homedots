{ config, pkgs, ... }:

let
    userApps = with pkgs; [
      motrix
      gparted
      brave
      mendeley
      vscodium-fhs
      joplin-desktop
      conda
      vlc
      onlyoffice-desktopeditors
      git
    ];

    appendApps = apps: userApps ++ apps; 
in{
    nixpkgs = {
        config = {
          allowUnfree = true;
          allowUnfreePredicate = (_: true);
        };
    };

    programs.git = {
      enable = true;
      userEmail = "adhavneeraj9500@gmail.com";
      userName = "neerajadhav";
    };

    home.username = "super";
    home.homeDirectory = "/home/super";
    home.packages = with pkgs; appendApps[];

    # Do not change below configs
    home.stateVersion = "24.11";
    programs.home-manager.enable = true;
}
