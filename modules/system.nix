{ config, lib, pkgs, ... } :

{ 
  home.packages = with pkgs; [
    bat
    fzf
    imagemagick
    mpv
    nix-search
    ncdu
    nh
    oh-my-zsh
    qalculate-qt
    tig
    timeshift
    zsh-autosuggestions
    niri
    xwayland-satellite
  ];
}