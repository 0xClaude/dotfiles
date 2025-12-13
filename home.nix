{ config, pkgs, dankMaterialShell, niri, ... }:

{
  home.username = "claude";
  home.homeDirectory = "/home/claude";
  home.stateVersion = "25.05";

  imports = [
    ./modules/system.nix
    ./modules/programs.nix
    ./modules/emacs.nix

    niri.homeModules.niri
    dankMaterialShell.homeModules.dankMaterialShell.default
    dankMaterialShell.homeModules.dankMaterialShell.niri
  ];

  programs.git = {
    enable = true;
    userName = "Claude BIVER";
    userEmail = "claude.biver@pm.me";
    extraConfig.init.defaultBranch = "main";
  };

  programs.ssh.enable = true;
  services.ssh-agent.enable = true;

  programs.vim.defaultEditor = true;

  programs.dankMaterialShell = {
    enable = true;
    niri = {
      enableKeybinds = true;   # Automatic keybinding configuration
      enableSpawn = true;      # Auto-start DMS with niri
    };
  };

  systemd.user.services.niri-flake-polkit.enable = false;

  home.packages = with pkgs; [
    # Add programs here
  ];

  home.file.".config/alacritty".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/alacritty";
    
}
