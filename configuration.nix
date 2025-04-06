# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      <home-manager/nixos>
    ];

   # Flatpak
   services.flatpak.enable = true;
   xdg.portal.extraPortals = [];
   xdg.portal.config.common.default = "gtk";

   # NFS
   services.nfs.server.enable = true;

   # VirtualBox
   #virtualisation.virtualbox.host.enable = true;
   #users.extraGroups.vboxusers.members = [ "simon" ];
   #virtualisation.virtualbox.host.enableExtensionPack = true;
   #virtualisation.virtualbox.guest.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.utf8";
    LC_IDENTIFICATION = "sv_SE.utf8";
    LC_MEASUREMENT = "sv_SE.utf8";
    LC_MONETARY = "sv_SE.utf8";
    LC_NAME = "sv_SE.utf8";
    LC_NUMERIC = "sv_SE.utf8";
    LC_PAPER = "sv_SE.utf8";
    LC_TELEPHONE = "sv_SE.utf8";
    LC_TIME = "sv_SE.utf8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Cinnamon Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.cinnamon.enable = true;

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "se";
    xkb.variant = "";
  };

  # Configure console keymap
  console.keyMap = "sv-latin1";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
   hardware.pulseaudio.enable = true;
   hardware.pulseaudio.support32Bit = true;    ## If compatibility with 32-bit applications is desired.

   
#  security.rtkit.enable = true;
  services.pipewire = {
    enable = false;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };


  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  
  #bluetooth

  hardware.enableAllFirmware = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    package = pkgs.bluez5-experimental;
    settings = {
      Policy.AutoEnable = "true";
#      General = {
#        Experimental = true;
#      };
#      LE = {
#      	ScanIntervalDiscovery = 48;
#        ScanWindowDiscovery = 48;
#     	CentralAddressResolution = 1;
#     	EnableAdvMonInterleaveScan = 1;
#      };
    };
  };

  services.blueman.enable = true; 

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.simon = {
    isNormalUser = true;
    description = "simon";
    extraGroups = [ "networkmanager" "wheel" "dialout" "audio" ];
    packages = with pkgs; [
#      firefox
    ];
  };

  home-manager.users.simon = { pkgs, ... }: {

    nixpkgs.config.allowUnfree = true;
    
    home.packages = with pkgs; [
      python311
     	discord
	    zoom-us
	    gimp
	    fish
	    gcc
      tree
	    cxxtest
      vscode
      valgrind
	    vscode-extensions.ms-vscode.cpptools
      typst
      zathura
      texliveTeTeX
	    spotify
   	  #matlab

      wineWowPackages.full

	    # Bluetooth
  	  bluez-alsa
     ];

     programs.bash.enable = true;
     programs.git = {
	    enable = true; 
	    userName = "bossersimon";
	    userEmail = "simon.bosser@gmail.com";
     };
     
     # The state version is required and should stay at the version you originally installed
     home.stateVersion = "24.11";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    neovim
    firefox
    git	
    direnv
    nix-direnv
    evince
  ];

  # Direnv
  programs.direnv.enable = true;
#  programs.bash.interactiveShellInit = ''eval "$(direnv hook bash)"'';


  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  environment.enableDebugInfo = true;

  # Enable the OpenSSH daemon.
   services.openssh.enable = true;

  # nix-ld 
   programs.nix-ld.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}


