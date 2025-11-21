{
	description = "NixOS";

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-25.05";

		# Add the unstable channel as a second nixpkgs
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

		home-manager = {
			url = "github:nix-community/home-manager/release-25.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		silentSDDM = {
			url = "github:uiriansan/SilentSDDM";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		# Beaver-notes
		beaver-notes-src = {
			url = "github:Beaver-Notes/Beaver-Notes";
			flake = false;
		};

	};

	outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, silentSDDM, beaver-notes-src, ... }: {

		nixosConfigurations.nebula = nixpkgs.lib.nixosSystem {

			system = "x86_64-linux";

			specialArgs = {
				sources = import ./pins;

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

					nixpkgs.overlays = [
						(import ./overlays/beaver-notes.nix {
							pkgs = import nixpkgs { system = "x86_64-linux"; };
							beaver-src = beaver-notes-src;
						})
					];

					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;
						users.claude = import ./home.nix;
						backupFileExtension = "backup";
					};
				}
			];
		};
	};
}
