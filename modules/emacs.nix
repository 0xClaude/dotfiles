{ pkgs, ... }:

# This attribute set will be imported into your home-manager configuration
{
  programs.emacs = {
    extraPackages = ep: [
      ep.vterm            # Terminal emulator inside Emacs
      ep.magit            # Git porcelain
      ep.material-theme   # A popular, clean theme
      
      # --- New Essential Packages ---
      ep.use-package      # Configuration macro for better organization
      ep.vertico          # Vertical, single-line completion UI
      ep.which-key        # Displays available keybindings after a prefix
    ];

    # 3. All Lisp configuration consolidated into 'extraConfig'.
    extraConfig = ''
      ;; --- 1. Basic UI Configuration ---
      (setq initial-scratch-message nil)     ; Clear the *scratch* buffer
      (setq inhibit-startup-message t)       ; Hide the splash screen

      ;; Use relative line numbers
      (global-display-line-numbers-mode 1)
      (setq display-line-numbers-type 'relative)

      ;; Show column numbers in the mode line
      (column-number-mode 1)

      ;; --- 2. Theme Configuration ---
      (add-to-list 'custom-theme-load-path (expand-file-name "~/.emacs.d/elpa/"))
      (load-theme 'material t)
      (set-face-attribute 'default nil :font "Iosevka SS08" :height 100)

      ;; --- 3. Keybindings (Magit and VTerm) ---
      (global-set-key (kbd "C-c C-v") 'vterm) ; VTerm
      (global-set-key (kbd "C-x g") 'magit-status) ; Magit

      ;; --- 4. Vertico (Modern Completion) Configuration ---
      (use-package vertico
        :init
        (vertico-mode)
        ;; Configure to display a maximum of 20 candidates
        (setq vertico-cycle t)
        (setq vertico-resize t)
        (setq vertico-count 20)) 

      ;; --- 5. Which-Key Configuration ---
      (use-package which-key
        :init
        (which-key-mode)
        ;; Set a slightly longer delay so it doesn't pop up too fast
        (setq which-key-idle-delay 0.5)
        (setq which-key-sort-order 'which-key-key-order)
        )
    '';
  };
}