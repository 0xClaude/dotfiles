{ config, lib, pkgs, ... } :

{ 
  home.packages = with pkgs; [
    bat
    nix-search
    ncdu
    nh
    oh-my-zsh
    timeshift
    zsh-autosuggestions
  ];
}