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


}