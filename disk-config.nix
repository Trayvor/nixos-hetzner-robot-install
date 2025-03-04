{ lib, ... }:
{
  disko.devices = {
    disk.nvme0 = {
      device = lib.mkDefault "/dev/nvme0n1";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          biosBoot = {
            name = "bios-boot";
            size = "1M";
            type = "EF02";
          };
          esp = {
            name = "ESP";
            size = "500M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          };
          lvm = {
            name = "lvm";
            size = "100%"; 
            content = {
              type = "lvm_pv";
              vg = "pool";
            };
          };
        };
      };
    };

    disk.nvme1 = {
      device = lib.mkDefault "/dev/nvme1n1";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          lvm = {
            name = "lvm";
            size = "100%";  
            content = {
              type = "lvm_pv";
              vg = "pool";
            };
          };
        };
      };
    };

    lvm_vg = {
      pool = {
        type = "lvm_vg";
        lvs = {
          root = {
            size = "100%"; 
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
              mountOptions = [ "defaults" ];
            };
          };
        };
      };
    };
  };
}
