{ config, pkgs, ... }:

{

  imports = [
    /etc/nixos/hardware-configuration.nix
  ];

  # paste your boot config here...
  #boot.loader.systemd-boot.enable = true;
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = { 
      enable = true;
      devices = [ "nodev" ];
      efiSupport = true;
      useOSProber = true;
    };
  };

  # systemd.services.wal-on-nitrogen = {
  # description = "Wal on nitrogen";
  # wantedBy = [ "multi-user.target" ];
  # serviceConfig = {
  #     ExecStart = "/home/super/.dotfiles/src/i3/autostart.sh";
  #     # Restart = "always";
  #   };
  # };
  
  # Networking
  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [];
      allowedUDPPorts = [];
    };
    hostName = "Nimbus-21";
    networkmanager.enable = true;
    #wireless.enable = true;
  };

  # edit as per your location and timezone
  time.timeZone = "Asia/Kolkata";
  i18n = {
    defaultLocale = "en_IN";
    extraLocaleSettings = {
      LC_ADDRESS = "en_IN";
      LC_IDENTIFICATION = "en_IN";
      LC_MEASUREMENT = "en_IN";
      LC_MONETARY = "en_IN";
      LC_NAME = "en_IN";
      LC_NUMERIC = "en_IN";
      LC_PAPER = "en_IN";
      LC_TELEPHONE = "en_IN";
      LC_TIME = "en_IN";
      LC_CTYPE="en_US.utf8"; # required by dmenu don't change this
    };
  };

  #sound.enable = true;

  services = {
    xserver = {
      xkb.layout = "us";
      xkb.variant = "";
      enable = true;
      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          i3status
 	        i3lock
        ];
      };
      desktopManager = {
        xterm.enable = false;
        xfce = {
          enable = true;
          noDesktop = true;
          enableXfwm = false;
        };
      };
      #displayManager = {
      #  lightdm.enable = true;
      #  defaultSession = "xfce+i3";
      #};
    };
   # displayManager = {
      #lightdm.enable = true;
     # defaultSession = "xfce+i3"
    #};
    gvfs.enable = true;
    gnome.gnome-keyring.enable = true;
    blueman.enable = true;
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };
    logind.extraConfig = ''
      # don’t shutdown when power button is short-pressed
      HandlePowerKey=ignore
    '';
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      pulseaudio = true;
    };
  };

  # Edit the username below (replace 'neeraj')
  users.users.super = {
    isNormalUser = true;
    description = "Super";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  environment.systemPackages = with pkgs; [
    alacritty
    dmenu
    git
    gnome-keyring
    networkmanagerapplet
    nitrogen
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
  ];

  programs = {
    #thunar.enable = true;
    dconf.enable = true;
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart =
          "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
  
  hardware = {
    bluetooth.enable = true;
  };

  # Don't touch this
  system.stateVersion = "24.11";
}
