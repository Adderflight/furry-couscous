# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "anothertestingVM"; # Define your hostname.
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "America/Detroit";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp3s0.useDHCP = true;
  #networking.interfaces.wlp4s0.useDHCP = true;
  # networking.nameservers = [ "192.168.1.124" "2600:1702:c0:b050::449" ];



networking = {
    # Don't try to find our domain name or DNS servers because then
    # resolvconf will insert them into /etc/resolv.conf
    dhcpcd.extraConfig =
      ''
      nooption domain_name_servers, domain_name, domain_search, host_name
      nooption ntp_servers
      nooption 1pv4only
      '';
    nameservers = [
      "192.168.1.124"
      "2600:1702:c0:b050::449"
    ];
};



  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;


  # Enable the Plasma 5 Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Enable xrdp
  #services.xrdp.enable = true;
  #services.xrdp.defaultWindowManager = "startplasma-x11";
  #networking.firewall.allowedTCPPorts = [ 3389 ]; 

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable bluetooth
  hardware.bluetooth.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Enable Virtualization
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.testuser123 = {
    isNormalUser = true;
    shell = pkgs.fish;
    initialPassword = "no";
    extraGroups = [ "wheel" "audio" "networkmanager" "libvirtd" ]; # Enable ‘sudo’ for the user.
  };
  
  #users.users.forrdp = {
    #isNormalUser = true;
    #shell = pkgs.fish;
    #initialPassword = "rdp";
    #extraGroups = [ "audio" ]; # Enable ‘sudo’ for the user.
  #};


  # Get the latest Kernel
  #boot.kernelPackages = pkgs.linuxPackages_latest;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
environment.systemPackages = with pkgs; [
  # browser
  firefox
  icecat-bin
  #tor-browser-bundle-bin # Not Working

  # word processing
  libreoffice-qt
  onlyoffice-bin
  vim
  joplin-desktop
  
  # terminal stuff
  kitty
  starship
  fish
  neofetch
  htop
  zsh

  # games 
  steam
  wine-staging

  # audio/videos/images
  strawberry
  yt-dlp
  hydrus
  gimp
  lxqt.pavucontrol-qt
  mpv

  # kde stuff
  krdc
  korganizer
  ark
  plasma-browser-integration
  kdeconnect
  krfb
  kmail
  plasma5Packages.kclock
  akonadi

  # dev
  git
  kate
  wget
  python
  python3

  # virtualization
  virt-manager

  # misc apps
  qbittorrent
  cemu
  keepassxc
  gnupg
  tdesktop
];

  # Enable fish and fish
  programs.fish.enable = true;
  programs.zsh.enable = true;
  environment.interactiveShellInit = ''
   [ -x /bin/fish ] && SHELL=/bin/fish exec fish 
  '';

  # Allow unfree licenses
  nixpkgs.config.allowUnfree = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

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
  system.stateVersion = "21.11"; # Did you read the comment?

}
