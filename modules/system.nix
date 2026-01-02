{ config, lib, pkgs, ... } :

{ 
  home.packages = with pkgs; [
    bat
    fzf
    gparted
    imagemagick
    kanshi
    mpv
    niri
    nix-search
    ncdu
    ntfs3g
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