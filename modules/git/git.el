;;; git.el --- Git configuration module

;;; Commentary:
;; Magit, Forge, and related Git tools.

;;; Code:

;; Source control
(use-package magit
  :bind (("C-c g s" . magit-status)
         ("C-x v s" . magit-status)))

(use-package magit-gh-pulls
  :hook (magit-mode-hook . turn-on-magit-gh-pulls))

(use-package forge)

(provide 'git-config-module)
;;; git.el ends here
