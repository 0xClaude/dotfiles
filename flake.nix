{
	description = "NixOS";

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-25.05";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

		home-manager = {
			url = "github:nix-community/home-manager/release-25.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		silentSDDM = {
			url = "github:uiriansan/SilentSDDM";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		# DMS
		dgop = {
      url = "github:AvengeMedia/dgop";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dankMaterialShell = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.dgop.follows = "dgop";
    };

		niri = {
  		url = "github:sodiboo/niri-flake";
  		inputs.nixpkgs.follows = "nixpkgs";
		};

	};

	outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, silentSDDM, dankMaterialShell, niri, ... }: {

		nixosConfigurations.nebula = nixpkgs.lib.nixosSystem {

			system = "x86_64-linux";

			specialArgs = {
				inherit silentSDDM;
				unstablePkgs = import nixpkgs-unstable {
					system = "x86_64-linux";
					config.allowUnfree = true;
				};
			};

			modules = [
				./configuration.nix
				home-manager.nixosModules.home-manager
				{
					nixpkgs.config.allowUnfree = true;

					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;

						extraSpecialArgs = {
							inherit dankMaterialShell niri;
						};

						users.claude = import ./home.nix;
						backupFileExtension = "backup";

					};
				}
			];
		};
	};
}
