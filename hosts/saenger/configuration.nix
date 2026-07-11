# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Enable experimental features nix-command and flakes
  nix.settings.experimental-features = "nix-command flakes";


  # Enable NVIDIA graphics modules
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = false;
  
/* # This can probably be deleted
  #PRIME hybrid graphics setup
  hardware.nvidia.prime = {
    intelBusId = "PCI:0@0:2:0";
    nvidiaBusId = "PCI:1@0:0:0";
    # amdgpuBusId = "PCI:5@0:0:0"; # If you have an AMD iGPU
  };*/

  # #Offload mode is to use the iGPU instead of dGPU unless
  # # For offloading, `modesetting` is needed additionally,
  # # otherwise the X-server will be running permanently on nvidia,
  # # thus keeping the GPU always on (see `nvidia-smi`).
  # services.xserver.videoDrivers = [
  #   "modesetting"  # example for Intel iGPU; use "amdgpu" here instead if your iGPU is AMD
  #   "nvidia"
  # ];
  # hardware.nvidia.open = false;
  # hardware.nvidia.prime = {
  #   offload.enable = true;

  #   intelBusId = "PCI:0@0:2:0";
  #   nvidiaBusId = "PCI:1@0:0:0";
  #   # amdgpuBusId = "PCI:5@0:0:0"; # If you have an AMD iGPU
  # };
  # #END OF Offload mode

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "saenger"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Seoul";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Set sleep time for sleep-then-hibernate
  systemd.sleep.settings.Sleep = {
    HibernateDelaySec = "30m";
    SuspendState = "mem";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # # Enable the KDE Plasma Desktop Environment.
  # services.displayManager.sddm.enable = true;
  # services.desktopManager.plasma6.enable = true;

  #enable hyprland
  programs.hyprland.enable = true; # enable Hyprland

  # Optional, hint Electron apps to use Wayland:
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";
  # End of Hyprland

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
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

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    neovim
    wget
    zsh
    vscodium
    wget
    git
    git-crypt
    gh
    expressvpn
    lynx
    kitty
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "no";
    allowSFTP = true;
  };

  # Laptop settings
  services.logind.settings.Login = {
    HandleLidSwitch = "suspend-then-hibernate";
    HandleLidSwitchExternalPower = "lock";
    HandleLidSwitchDocked = "ignore";
  };

  # one of "ignore", "poweroff", "reboot", "halt", "kexec", "suspend", "hibernate", "hybrid-sleep", "suspend-then-hibernate", "lock"

  # # Power Management
  # powerManagement.enable = true;
  # # CPU Power Scaling
  # services.thermald.enable = true;

  # disabled due to interfering with KDE power management
/*
  # tlp
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_ACE = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 20;

      # Optional helps save lon term battery health
      START_CHARGE_THRESH_BAT0 = 40; # 40 and below starts to charge
      STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above stop charging
    };
  };
*/
  # # Set max battery charge to 80%
  # systemd.services.clevo-battery-limit = {
  #   description = "Set Clevo Battery Charge Limit";
  #   after = [ "multi-user.target" ];
  #   wantedBy = [ "multi-user.target" ];
  #   serviceConfig = {
  #     Type = "oneshot";
  #     RemainAfterExit = true;
  #     # Sets charge limit to 80%. Change to 60, 70, 80, or 90.
  #     ExecStart = "${pkgs.bash}/bin/bash -c 'echo 80 > /sys/class/power_supply/BAT0/charge_control_end_threshold || true'";
  #   };
  # };

  # Hybrid Graphics
  
  /* Via specialization
  specialisation = {
    nvidia.configuration = {
      # Nvidia Configuration
      services.xserver.videoDrivers = [ "nvidia" ];
      hardware.graphics.enable = true;

      # Optionally, you may need to select the appropriate driver version for your specific GPU.
      hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

      # nvidia-drm.modeset=1 is required for some wayland compositors, e.g. sway
      hardware.nvidia.modesetting.enable = true;

      hardware.nvidia.prime = {
        sync.enable = true;

        # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA
        nvidiaBusId = "PCI:1@0:0:0";
        # 01:00.0 VGA compatible controller: NVIDIA Corporation TU106M [GeForce RTX 2070 Mobile] (rev a1)

        # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA
        intelBusId = "PCI:0@0:2:0";
        # 00:02.0 VGA compatible controller: Intel Corporation CoffeeLake-H GT2 [UHD Graphics 630]
      };
    };
  };*/
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
  system.stateVersion = "25.11"; # Did you read the comment?

}
