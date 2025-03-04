That configuration was tested on Hetzner Robot machine with such configuration:
```
Hardware data:
   CPU1: Intel(R) Xeon(R) CPU E3-1275 v5 @ 3.60GHz (Cores 8)
   Memory:  64099 MB
   Disk /dev/nvme0n1: 512 GB (=> 476 GiB)
   Disk /dev/nvme1n1: 512 GB (=> 476 GiB)
   Total capacity 953 GiB with 2 Disks
Network data:
   eth0  LINK: yes
         MAC:  
         IP:   
         IPv6: 
         Intel(R) PRO/1000 Network Driver
```
         
1. Boot turn on rescure system boot on hetzner website and reboot machine
2. Paste your ssh in configuration.nix
3. Configure disk-config.nix
4. `nix flake lock`
5. `nix run github:nix-community/nixos-anywhere -- --generate-hardware-config nixos-generate-config ./hardware-configuration.nix --flake .#generic --target-host root<ip>`
    
