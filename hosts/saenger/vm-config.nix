{
  # Needed for disko to work in vm
  boot.initrd.availableKernelModules = [ 
    "virtio_pci" 
    "virtio_blk" 
    "virtio_scsi" 
    "virtio_balloon" 
    "virtio_console" 
    "virtio_net"
  ];
}