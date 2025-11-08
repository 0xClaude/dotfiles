{ pkgs, ... }:
{
  home.packages = with pkgs; [
    libvterm # Required for vterm
    iosevka  # Font for Emacs
  ];

  programs.emacs = {
    enable = true;
    package = (pkgs.emacsPackagesFor pkgs.emacs).emacsWithPackages (ep: [
      ep.vterm
      ep.magit
      ep.material-theme
      ep.use-package
      ep.vertico
      ep.which-key
    ]);

    extraConfig = ''
      ;; Ensure use-package is loaded
      (require 'use-package)

      ;; --- 1. Basic UI Configuration ---
      (setq initial-scratch-message nil)
      (setq inhibit-startup-message t)
      (global-display-line-numbers-mode 1)
      (setq display-line-numbers-type 'relative)
      (column-number-mode 1)

      ;; --- 2. Theme Configuration ---
      (load-theme 'catppucinx t)
      (set-face-attribute 'default nil :font "Iosevka" :height 100)

      ;; --- 3. Keybindings ---
      (use-package vterm
        :config
        (global-set-key (kbd "C-c C-v") 'vterm))

      (use-package magit
        :config
        (global-set-key (kbd "C-x g") 'magit-status))

      ;; --- 4. Vertico Configuration ---
      (use-package vertico
        :init
        (vertico-mode)
        :config
        (setq vertico-cycle t)
        (setq vertico-resize t)
        (setq vertico-count 20))

      ;; --- 5. Which-Key Configuration ---
      (use-package which-key
        :init
        (which-key-mode)
        :config
        (setq which-key-idle-delay 0.5)
        (setq which-key-sort-order 'which-key-key-order))
    '';
  };
}