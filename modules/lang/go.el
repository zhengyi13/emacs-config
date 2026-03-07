;;; go.el --- Go language configuration module

;;; Commentary:
;; Go mode, testing, and tagging.

;;; Code:

(use-package go-mode
  :hook (go-mode . lsp-deferred)
  :config
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))

(use-package gotest
  :bind (
	 ("C-c t t" . go-test-current-test)
	 ("C-c t f" . go-test-current-file)
	 ("C-c t p" . go-test-current-project)))

(use-package go-tag
  :config
  (defun jbm/add-json-tags () (interactive)(go-tag-add "json"))
  (defun jbm/add-xml-tags () (interactive)(go-tag-add "xml"))
  :bind (
	 ("C-c g j" . jbm/add-json-tags)
	 ("C-c g x" . jbm/add-xml-tags)
	 ("C-c g r" . go-tag-refresh)
	 ("C-c g R" . go-tag-remove)
	 ("C-c g a" . go-tag-add)))

(provide 'lang-go-module)
;;; go.el ends here
