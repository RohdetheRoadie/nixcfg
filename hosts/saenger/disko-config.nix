{
  disko.devices = {
    disk = {
      nixos = {
        type = "disk";
        # SSD hardware identifier
        # device = "/dev/nvme0n1"; #Enable for HDD/disable for VM
        device = "/dev/vda"; # This is for building on VM
        content = {
          type = "gpt";
          partitions = {
            # boot = {
            #   size = "1024M";
            #   type = "EF02"; # for grub MBR
            # };
            #Try this out to make bootable (VM didn't like the other way)
            ESP = {
              name = "ESP";
              start = "1MiB";
              end = "1024MiB";
              bootable = true;
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
    };
  };
}
