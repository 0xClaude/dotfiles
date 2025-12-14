{ config, lib, pkgs, ... } :

{ 
  home.packages = with pkgs; [
    bat
    fzf
    imagemagick
    mpv
    niri
    nix-search
    ncdu
    nh
    oh-my-zsh
    qalculate-qt
    swaylock
    tig
    timeshift
    yazi
    zsh-autosuggestions
  ];
}