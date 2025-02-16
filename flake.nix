{
  description = "alice nixos config!!!";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [
        (final: prev: {
          unstable = import nixpkgs-unstable {
            system = prev.system;
          };
        })
      ];
    };
  in
  {
    nixosConfigurations = {
      orka = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit pkgs; };
        modules = [ ./orka/configuration.nix ];
      };
      haai = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit pkgs; };
	modules = [ ./haai/configuration.nix ];
      };
    };
  };
}
