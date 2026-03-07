;;; terraform.el --- Terraform language configuration module

;;; Code:

(use-package terraform-mode
  :hook (terraform-mode . lsp-deferred))

(provide 'lang-terraform-module)
;;; terraform.el ends here
