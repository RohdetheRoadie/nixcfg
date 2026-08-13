## This one should work for NVME
# {
#   disko.devices = {
#     disk = {
#       nixos = {
#         # SSD hardware identifier use /dev/sda for hdd
#         device = "/dev/nvme0n1"; #Enable for HDD/disable for VM
#         type = "disk";
#         content = {
#           type = "gpt";
#           partitions = {
#             # boot = {
#             #   size = "1024M";
#             #   type = "EF02"; # for grub MBR
#             # };
#             #Try this out to make bootable (VM didn't like the other way)
#             ESP = {
#               size = "512M";
#               type = "EF00";
#               content = {
#                 type = "filesystem";
#                 format = "vfat";
#                 mountpoint = "/boot";
#                 mountOptions = [ "umask=0077" ];
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

# This one works for VM
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