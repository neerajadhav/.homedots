{ config, pkgs, ... }:

let
    userApps = with pkgs; [
      motrix
      brave
      mendeley
      joplin-desktop
      conda
      vlc
      onlyoffice-desktopeditors
      git
      obsidian
    ];

    fonts = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
      mplus-outline-fonts.githubRelease
      nerd-fonts.hack
    ];

    appendApps = apps: userApps ++ fonts ++ apps; 
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

    fonts.fontconfig.enable = true;

    # Do not change below configs
    home.stateVersion = "24.11";
    programs.home-manager.enable = true;
}
