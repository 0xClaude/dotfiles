{ pkgs, ... }:

# This attribute set will be imported into your home-manager configuration
{
  programs.emacs = {
    # 1. Enable Emacs configuration
    enable = true;
    
    # 2. Add packages (e.g., a nice theme and useful utilities)
    package = pkgs.emacs29; # Or whichever version you prefer
    
    extraPackages = ep: [
      ep.vterm        # Terminal emulator inside Emacs
      ep.magit        # The best Git porcelain for Emacs
      ep.material-theme # A popular, clean theme
    ];

    # 3. Define the main configuration (init.el content)
    # Lisp code that runs early (before packages are necessarily loaded).
    preInit = ''
      ;; --- Basic UI Configuration ---
      (setq initial-scratch-message nil)     ; Clear the *scratch* buffer
      (setq inhibit-startup-message t)       ; Hide the splash screen

      ;; Use relative line numbers
      (global-display-line-numbers-mode 1)
      (setq display-line-numbers-type 'relative)

      ;; Show column numbers in the mode line
      (column-number-mode 1)

      ;; --- Theme Configuration ---
      (add-to-list 'custom-theme-load-path (expand-file-name "~/.emacs.d/elpa/"))
      (load-theme 'material t)
      (set-face-attribute 'default nil :font "Iosevka SS08" :height 100)
    '';

    # 4. Keybinding and Magit Setup
    # Corrected: Use 'extraConfig' for Lisp that relies on packages being loaded.
    extraConfig = ''
      ;; Global keybinding for VTerm (embedded terminal)
      (global-set-key (kbd "C-c C-v") 'vterm)
      
      ;; Bind Magit-status to C-x g (a traditional binding)
      (global-set-key (kbd "C-x g") 'magit-status)
    '';
  };
}