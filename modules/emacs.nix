{ pkgs, ... }:
{
  home.packages = with pkgs; [
    libvterm # Required for vterm
  ];

  programs.emacs = {
    enable = true;
    package = (pkgs.emacsPackagesFor pkgs.emacs).emacsWithPackages (ep: [
      ep.vterm
      ep.magit
      ep.use-package
      ep.vertico
      ep.which-key
      ep.nix-mode
    ]);

    # TODO this belongs into its own config file
    extraConfig = ''
      ;; Ensure use-package is loaded
      (require 'use-package)

      (setq initial-scratch-message nil)
      (setq inhibit-startup-message t)
      (global-display-line-numbers-mode 1)
      (setq display-line-numbers-type 'relative)
      (column-number-mode 1)

      (load-theme 'catppuccin t)
      
      (use-package vterm
        :config
        (global-set-key (kbd "C-c C-v") 'vterm))

      (use-package magit
        :config
        (global-set-key (kbd "C-x g") 'magit-status))

      (use-package vertico
        :init
        (vertico-mode)
        :config
        (setq vertico-cycle t)
        (setq vertico-resize t)
        (setq vertico-count 20))

      (use-package which-key
        :init
        (which-key-mode)
        :config
        (setq which-key-idle-delay 0.5)
        (setq which-key-sort-order 'which-key-key-order))

       (global-set-key (kbd "C-c l") #'org-store-link)
       (global-set-key (kbd "C-c a") #'org-agenda)
       (global-set-key (kbd "C-c c") #'org-capture)
    '';
  };
}
