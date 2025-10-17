{ config, pkgs, ... }:

{
  home.username = "claude";
  home.homeDirectory = "/home/claude";
  home.stateVersion = "25.05";

  imports = [
    ./modules/system.nix
    ./modules/programs.nix
  ];

  programs.git = {
    enable = true;
    userName = "Claude BIVER";
    userEmail = "claude.biver@pm.me";
    extraConfig.init.defaultBranch = "main";
  };

  programs.ssh.enable = true;
  services.ssh-agent.enable = true;

  home.packages = with pkgs; [
    # Add programs here
  ];

  home.file.".config/alacritty".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/alacritty";
    
}
