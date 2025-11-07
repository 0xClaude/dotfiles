{ config, lib, pkgs, ... } :

{ 
  home.packages = with pkgs; [
    bat
    emacs
    nix-search
    ncdu
    nh
    oh-my-zsh
    timeshift
    zsh-autosuggestions
  ];
}