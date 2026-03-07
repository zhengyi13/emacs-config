;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; All The Pretty Things

(use-package treemacs)
(use-package nerd-icons)
(use-package treemacs-nerd-icons
  :config
  (treemacs-load-theme "nerd-icons"))

(use-package nerd-icons-completion
  :config
  (nerd-icons-completion-mode))

(use-package doom-themes
  :init (load-theme 'doom-dracula t))

;; This all assumes a functional terminal with a patched font being
;; used by the terminal. Currently I'm on Windows 11's Terminal
;; Preview 1.18.?? using "Inconsolata Nerd Font" from `choco install
;; nerd-fonts-inconsolata`
(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom (
	   (setq doom-modeline-enable-word-count t)
	   (setq doom-modeline-unicode-fallback nil)
	   (setq doom-modeline-icon t)
	   (setq doom-modeline-major-mode-icon t)
	   (setq doom-modeline-major-mode-color-icon t)
	   (setq doom-modeline-buffer-state-icon t)
	   (setq doom-modeline-buffer-modification-icon t)
	   (doom-modeline-height 35)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Utility / Ergonomics

(use-package which-key
    :defer 0
    :diminish which-key-mode
    :config
    (which-key-mode)
    (setq which-key-idle-delay 1))

;; Jump around, jump around, jump up jump up and get down
(use-package ace-jump-mode
  :bind ("M-o" . ace-window))

(use-package avy
  :bind ("M-g M-g" . avy-goto-line))

(provide 'ui-ui)
