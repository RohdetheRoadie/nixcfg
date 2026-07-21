{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let 
  cfg = config.features.cli.fish;
  in {
  options.features.cli.fish.enable = mkEnableOption "enable extended fish configuration";

  config = mkIf cfg.enable {
    programs.fish = {
      enable = true;
      loginShellInit = ''
        set -x NIX_PATH nixpkgs=channel:nixos-unstable
        set -x NIX_LOG info
        set -x TERMINAL alacritty

        # # If login manager fails this will get you to desktop automatically
        # if text (tty) = "/dev/tty1"
        #   exec niri-session &> /dev/nul
        # end
      '';
      shellAbbrs = {
        ".." = "cd ..";
        "..." = "cd ../..";
        ls = "eza";
        grep = "rg";
        ps = "procs";
      };
    };
  };
}