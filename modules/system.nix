{ config, lib, pkgs, ... } :

{ 
  home.packages = with pkgs; [
    bat
    fzf
    gparted
    imagemagick
    mpv
    niri
    nix-search
    ncdu
    nh
    oh-my-zsh
    qalculate-qt
    parted
    speedtest-cli
    swaylock
    tig
    timeshift
    yazi
    zsh-autosuggestions
  ];
}