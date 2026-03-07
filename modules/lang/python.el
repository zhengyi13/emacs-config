;;; python.el --- Python language configuration module

;;; Code:

(use-package python
  :hook (python-mode . lsp-deferred))

(provide 'lang-python-module)
;;; python.el ends here
