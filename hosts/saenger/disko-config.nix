# {
#   disko.devices = {
#     disk = {
#       nixos = {
#         type = "disk";
#         # SSD hardware identifier
#         # device = "/dev/nvme0n1"; #Enable for HDD/disable for VM
#         device = "/dev/vda"; # This is for building on VM
#         content = {
#           type = "gpt";
#           partitions = {
#             # boot = {
#             #   size = "1024M";
#             #   type = "EF02"; # for grub MBR
#             # };
#             #Try this out to make bootable (VM didn't like the other way)
#             ESP = {
#               name = "ESP";
#               size = "1G";
#               type = "EF00";
#               # bootable = true; #No longer used
#               content = {
#                 type = "filesystem";
#                 format = "vfat";
#                 mountpoint = "/boot";
#                 mountOptions = [ "fmask=0077" "dmask=0077" ];
#               };
#             };
#             root = {
#               size = "100%";
#               content = {
#                 type = "filesystem";
#                 format = "ext4";
#                 mountpoint = "/";
#               };
#             };
#           };
#         };
#       };
#     };
#   };
# }
{
  disko.devices = {
    disk = {
      nixos = {
        type = "disk";
        device = "/dev/vda";
        content = {
          type = "gpt";
          partitions = {
            boot = {
              size = "1M";
              type = "EF02"; # for grub MBR
            };
            ESP = {
              size = "512M";
              type = "EF00";
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
