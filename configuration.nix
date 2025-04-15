{
  modulesPath,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disk-config.nix
    "${pkgs.code-server}/share/nixos/module.nix"
  ];
  boot.loader.grub = {
    # no need to set devices, disko will add all devices that have a EF02 partition to the list already
    # devices = [ ];
    efiSupport = true;
    efiInstallAsRemovable = true;
  };
  services.openssh.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 8080 ];
  services.code-server = {
    enable = true;
    user = "root";
    port = 8080;
    auth = "password";  
    password = "strongpass";  
  };

  environment.systemPackages = map lib.lowPrio [
    pkgs.zsh
    pkgs.curl
    pkgs.gitMinimal
    pkgs.htop
    pkgs.python311
    pkgs.python311Packages.pip
    pkgs.tmux
    pkgs.openssh
    pkgs.nano
    pkgs.git
    pkgs.gh
  ];

  users.users.root.openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDsQ6srSVBrCW79sxolSgX+jTK/TIOTUxuzgRMadcrdidZoHEjNIx1KrgCLF02tDg24eC+63LHBik+Olp/efPk6ghYb7d/GRflrzuRE2mCgxrtbxICM1TxzRpUMWQ1RSfDLwR7vT4Qbz+EGhfWfPfqWt4cYERKD+i+5RiphSKxczATa4dyXJSxXjb88VhoUCUY9fsmIgMG2GoP2omkCDNtZmzvw9ppPHUUxf/6ZFoaPTerYC84dGduKZJ0e6MknvsiCTMBbfJ5UaLy3niHzXL+hy10mcaQzgCg7spfMOoblVLZutONJW9VwHth7IbkP4ACLKHG96UOeUILagU8VqF7XusnbHQU0O2OtdAzxnb15B4LYaYZM7aPYlU4m/yheBPcO5pVZFBBkuTo4ppmFWfCd1o6D+fWZlHyZ4MurKO+ZzwtIgbf1D6VcCNtnWALrbEcMXGvaJ7MHQywUzjApM+cFGDCWMQ4OgzOFmEW1KEItx96vzovVYNDnIRGlHmag+Ysv1Gx/s/WwKXJCN4p7cWcPP4cc3LbwTvFwwplH8HNhdHJ0cjFZsNCdItM/olZj44mvWlwZwWMXj1rsExqxmKhmBmrCgIoy/E4a8UtiLoZUW7UKQ5ezB4XV1zjRPEYNQIilB/rGRmS8OAH02T+o9TpwGgSDwIXCjk99zIangVgxoQ== vladyslav.herasymenkoo@gmail.com" ];
  users.users.user = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };
  users.users.user.openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDsQ6srSVBrCW79sxolSgX+jTK/TIOTUxuzgRMadcrdidZoHEjNIx1KrgCLF02tDg24eC+63LHBik+Olp/efPk6ghYb7d/GRflrzuRE2mCgxrtbxICM1TxzRpUMWQ1RSfDLwR7vT4Qbz+EGhfWfPfqWt4cYERKD+i+5RiphSKxczATa4dyXJSxXjb88VhoUCUY9fsmIgMG2GoP2omkCDNtZmzvw9ppPHUUxf/6ZFoaPTerYC84dGduKZJ0e6MknvsiCTMBbfJ5UaLy3niHzXL+hy10mcaQzgCg7spfMOoblVLZutONJW9VwHth7IbkP4ACLKHG96UOeUILagU8VqF7XusnbHQU0O2OtdAzxnb15B4LYaYZM7aPYlU4m/yheBPcO5pVZFBBkuTo4ppmFWfCd1o6D+fWZlHyZ4MurKO+ZzwtIgbf1D6VcCNtnWALrbEcMXGvaJ7MHQywUzjApM+cFGDCWMQ4OgzOFmEW1KEItx96vzovVYNDnIRGlHmag+Ysv1Gx/s/WwKXJCN4p7cWcPP4cc3LbwTvFwwplH8HNhdHJ0cjFZsNCdItM/olZj44mvWlwZwWMXj1rsExqxmKhmBmrCgIoy/E4a8UtiLoZUW7UKQ5ezB4XV1zjRPEYNQIilB/rGRmS8OAH02T+o9TpwGgSDwIXCjk99zIangVgxoQ== vladyslav.herasymenkoo@gmail.com" ];


  system.stateVersion = "24.05";
  programs.zsh.enable = true;
}