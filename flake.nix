{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.disko.url = "github:nix-community/disko";
  inputs.disko.inputs.nixpkgs.follows = "nixpkgs";
  inputs.nixos-facter-modules.url = "github:numtide/nixos-facter-modules";
  inputs.vscode-server.url = "github:nix-community/nixos-vscode-server";

  outputs =
    {
      nixpkgs,
      disko,
      nixos-facter-modules,
      vscode-server,
      ...
    }:
    {
      # Use this for all other targets
      # nixos-anywhere --flake .#generic --generate-hardware-config nixos-generate-config ./hardware-configuration.nix <hostname>
      nixosConfigurations.generic = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          vscode-server.nixosModules.default
          ({ config, pkgs, ... }: {
            services.vscode-server.enable = true;
          })
          disko.nixosModules.disko
          ./disk-config.nix
          ./configuration.nix
          ./hardware-configuration.nix
        ];
      };
    };
}
