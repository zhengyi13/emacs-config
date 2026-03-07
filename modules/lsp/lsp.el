;;; lsp.el --- LSP configuration module

;;; Commentary:
;; Configuring LSP (and DAP, sorta)

;;; Code:

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :custom
  (lsp-completion-provider :none) ;; We use corfu, so don't try to autoconfigure company/capf
  (lsp-go-analyses '(
                     (asmdecl . t)
                     (assign . t)
                     (atomic . t)
                     (atomicalign . t)
                     (bools . t)
                     (buildtag . t)
                     (cgocall . t)
                     (composites . t)
                     (copylocks . t)
                     (deepequalerrors . t)
                     (embed . t)
                     (errorsas . t)
                     (httpresponse . t)
                     (ifaceassert . t)
                     (infertypeargs . t)
                     (loopclosure . t)
                     (lostcancel . t)
                     (nilfunc . t)
                     (nilness . t)
                     (printf . t)
                     (shadow . t)
                     (shift . t)
                     (simplifycompositelit . t)
                     (simplifyrange . t)
                     (simplifyslice . t)
                     (sortslice . t)
                     (stdmethods . t)
                     (stringintconv . t)
                     (structtag . t)
                     (testinggoroutine . t)
                     (tests . t)
                     (timeformat . t)
                     (unmarshal . t)
                     (unreachable . t)
                     (unsafeptr . t)
                     (unusedparams . t)
                     (unusedresult . t)
                     (unusedwrite . t)
                     (useany . t)
                     (fillreturns . t)
                     (nonewvars . t)
                     (noresultvalues . t)
                     (undeclaredname . t)
                     (unusedvariable . t)
                     (fillstruct . t)
                     (stubmethods . t)
                     ))

  :init
  (setq lsp-keymap-prefix "C-c l")

  (defun jbm/lsp-mode-setup ()
    (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
    (lsp-headerline-breadcrumb-mode))

  (defun jbm/lsp-mode-setup-completion ()
    (setf (alist-get 'styles (alist-get 'lsp-capf completion-category-defaults))
          '(flex))) ;; Configure flex

  :hook ((go-mode . lsp-deferred)
	 (python-mode . lsp-deferred)
	 (terraform-mode . lsp-deferred)
	 (lsp-mode . jbm/lsp-mode-setup)
	 (lsp-mode . lsp-enable-which-key-integration)
	 (lsp-completion-mode . jbm/lsp-mode-setup-completion)))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-position 'bottom)
  (lsp-ui-doc-enable))

(use-package lsp-treemacs
  :init (lsp-treemacs-sync-mode 1))

;; Integration with the debug server 
(use-package dap-mode
  :ensure t
  :defer t
  :after lsp-mode)

(provide 'lsp-config-module)
;;; lsp.el ends here
