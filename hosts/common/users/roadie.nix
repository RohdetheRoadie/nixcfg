{
  config,
  pkgs,
  inputs,
  ...
}: {
  users.users.roadie = {
    initialHashedPassword = "$6$5yZo902mPEW6Ckp.$gv5JCt871xVx2RZUcPGq8pLIj37epHecTlnT2WnPtGgghLur70uywzjrCs.kl9wSDnch/Hs1Gg2zt8lwWzNF2/";
    isNormalUser = true;
    description = "roadie";
    extraGroups = [
      "wheel"
      "networkmanager"
      "libvirtd"
      "flatpak"
      "audio"
      "video"
      "plugdev"
      "input"
      "kvm"
      "qemu-libvirtd"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHTwfpc7NLFJqCldm0HUM/ksW1+7hMuAqkaNoaUHld9f roadie@b2"
    ];
    packages = [inputs.home-manager.packages.${pkgs.system}.default];
  };
  home-manager.users.roadie =
    import ../../../home/roadie/${config.networking.hostName}.nix;
}
