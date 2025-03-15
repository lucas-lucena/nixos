# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Fortaleza";

  # The font to be used on the console when logging in.  Since most people
  # only use Japanese in X, you can leave this as the default value.
  i18n.consoleFont = "Lat2-Terminus16";

  # Select internationalisation properties.
  i18n.defaultLocale = "pt_BR.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  fonts = {
    enableDefaultFonts = true;

    # Enable fonts to use on your system.  You should make sure to add at least
    # one English font (like dejavu_fonts), as well as Japanese fonts like
    # "ipafont" and "kochi-substitute".
    fonts = with pkgs; [
      noto-fonts
      noto-fonts-emoji
      noto-fonts-cjk-sans
      ubuntu_font_family
      unifont
      carlito
      dejavu_fonts
      ipafont
      kochi-substitute
      source-code-pro
      ttf_bitstream_vera
      fira-code
      fira-code-symbols
    ];

    fontconfig = {
      antialias = true;
      
      # These settings enable default fonts for your system.  This setting is very
      # important.  It lets fontconfig know that you want to fall back to a Japanese
      # font (for example "IPAGothic") if an application tries to show fonts with
      # Japanese.  For instance, this is important if you are using a terminal
      # emulator and you `cat` some Japanese text to the screen. If you don't have
      # "defaultFonts" configured, fontconfig will pick a random Japanese font to
      # use.  If you have this "defaultFonts" setting configured, fontconfig will
      # pick the font you have selected.  This makes sure Japanese fonts look nice.
      defaultFonts = {
        monospace = [
          "DejaVu Sans Mono"
          "IPAGothic"
        ];
        sansSerif = [
          "DejaVu Sans"
          "IPAPGothic"
        ];
        serif = [
          "DejaVu Serif"
          "IPAPMincho"
        ];
      };
    };
  };

  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.addons = with pkgs; [
      fcitx5-gtk             # alternatively, kdePackages.fcitx5-qt
      fcitx5-chinese-addons  # table input method support
      fcitx5-mozc	     # Japanese
      fcitx5-hangul	     # Korean
      fcitx5-nord            # a color theme
      fcitx5-m17n	     # Multi
    ];
  };


  # This enables "fcitx" as your IME.  This is an easy-to-use IME.  It supports many different input methods.

  # This enables "mozc" as an input method in "fcitx".  This has a relatively
  # complete dictionary.  I recommend it for Japanese input.

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable OpelGL --Modification made by user
  hardware.opengl = {
    enable = true;
    #driSupport = true;
    #driSupport32Bit = true;
  };

  # Enable Nvidia drivers --Modification made by user
  services.xserver.videoDrivers = ["nvidia"];
  #hardware.nvidia.modesetting.enable = true;
  hardware.nvidia = {
    #enable = true;
    open = true;
    modesetting.enable = true;
    #drivers = ["linux" "nvidia"];
  };

  # Enable Steam --Modification made by user
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.hanekawa = {
    isNormalUser = true;
    description = "Hanekawa Tsubasa";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Enable partition manager
  programs.partition-manager.enable = true;

  # Enable Flatpak support
  services.flatpak.enable = true;

  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.config.common.default = "gtk";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
	neovim
        vim
        nano
        vscode
	git
	vlc
	mpv
	mpc-qt
	qbittorrent
	anki
	brave
	ungoogled-chromium
	python311
	jdk17
	postgresql
	docker
	docker-compose
	alacritty
	kitty
	discord
	wine
	stremio

	# Games section
	steam
	mangohud #Game monitoring --Modification made by user
	protonup #Just run protonup on terminal --Modification made by user
	lutris   #Games --Modification made by user 
	bottles  #Games --Modification made by user

	# Emulators
	retroarchFull	# Retro
	duckstation 	# PSX
	pcsx2		# PS2
	rpcs3		# PS3
	shadps4		# PS4
	ppsspp		# PSP
	xemu		# OG Xbox
	dolphin-emu	# Wii
	cemu		# Wii U
	melonDS		# NDS
	lime3ds		# 3DS
	ryujinx		# Switch
	flycast		# Dreamcast


  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  ];

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/hanekawa/.steam/root/compatibilitytools.d";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

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
  system.stateVersion = "24.11"; # Did you read the comment?

}
