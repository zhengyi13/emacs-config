;;; core.el --- Core loading mechanism for modular Emacs configuration

;;; Commentary:
;; This file defines the core loading mechanism for the modular configuration.

;;; Code:

(defun jbm/load-module (category module)
  "Load a MODULE from a CATEGORY within the modules directory.
CATEGORY is a symbol representing the subdirectory in ~/.emacs.d/modules/.
MODULE is a symbol representing the file name (without .el extension)."
  (let ((file (expand-file-name (format "modules/%s/%s.el" category module) user-emacs-directory)))
    (if (file-exists-p file)
        (load file nil 'nomessage)
      (message "Module not found: %s/%s" category module))))

(provide 'core)
;;; core.el ends here
