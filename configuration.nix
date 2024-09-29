# Edit this configuration file to define what should be installed on your system.  Help is available in the configuration.nix(5) man page and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{ 
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix 
    ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "nixos"; # Define your hostname.

  # Enable networking with static ip
  networking.networkmanager.enable = true;
  #networking.interfaces.eno1.ipv4.addresses = [{ 
  #  address = "10.220.91.231";
  #  prefixLength = 24;
  #}];
  networking.enableIPv6 = false;
  
  # -- Use pihole for dns
  networking.networkmanager.insertNameservers = [ "10.220.91.230" ];

  # Set your time zone
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = { 
    LC_ADDRESS = "de_DE.UTF-8"; 
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = { 
    layout = "us"; 
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.makarh = { 
    isNormalUser = true; 
    description = "Makar H"; 
    extraGroups = [ "networkmanager" "wheel" ]; 
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run: $ nix search wget
  environment.systemPackages = with pkgs; [
    git 
    gh 
    neovim 
    libgcc
  ];
  
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
    };
  };
  # Some programs need SUID wrappers, can be configured further or are started in user sessions. programs.mtr.enable = true; programs.gnupg.agent = {
  #   enable = true; enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # OpenSSH 
  services.openssh = { 
    enable = true;
    ports = [ 1111 ];
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };
  # Open ports in the firewall. networking.firewall.allowedTCPPorts = [ ... ]; networking.firewall.allowedUDPPorts = [ ... ]; Or disable the firewall altogether. networking.firewall.enable = false;

  # This value determines the NixOS release from which the default settings for stateful data, like file locations and database versions on your system were taken. It‘s perfectly fine and recommended to leave this value at 
  # the release version of the first install of this system. Before changing this value read the documentation for this option (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
