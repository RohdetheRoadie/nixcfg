{pkgs, ...}: {
  # Laptop settings - in iron-config
  services.logind.settings.Login = {
    HandleLidSwitch = "suspend-then-hibernate";
    HandleLidSwitchExternalPower = "lock";
    HandleLidSwitchDocked = "ignore";
  };

  # Set max battery charge to 80%
  systemd.services.clevo-battery-limit = {
    description = "Set Clevo Battery Charge Limit";
    after = [ "multi-user.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      # Sets charge limit to 80%. Change to 60, 70, 80, or 90.
      ExecStart = "${pkgs.bash}/bin/bash -c 'echo 80 > /sys/class/power_supply/BAT0/charge_control_end_threshold || true'";
    };
  };

  # If'd out because we're using disko for VM
  # Get rid of config=section, it doesn't work
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/d42f589a-e4a6-43eb-beca-2c30a31d97e5";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/8F09-854A";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/c0b2bb90-1393-4070-9871-05b2f969e363"; }
    ];


}