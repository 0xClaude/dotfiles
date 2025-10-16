{ config, lib, pkgs, ... } :

{ 
    home.packages = with pkgs; [
      bat
      nix-search
      ncdu
      nh
      oh-my-zsh
      qalculate-qt
      timeshift
      zsh-autosuggestions
    ];
}