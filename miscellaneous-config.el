
;; The default backup settings are bullshit. We're not going to turn
;; them off, but we will at least put everything under an 'auto-save'
;; directory under '~/.emacs'.
(use-package no-littering
  :init
  (setq no-littering-var-directory
	(expand-file-name "backups/" user-emacs-directory))
  (setq auto-save-file-name-transforms
	`((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))
  (no-littering-theme-backups))

(use-package vterm)

(use-package elfeed
  :bind ("C-c w" . elfeed)
  )

;; Pretty LISP
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))
(use-package smartparens
  :defer)

;; Misc prog modes
(use-package yasnippet
  :init
  (yas-global-mode 1))

(use-package journalctl-mode)


(provide 'miscellaneous-config)
