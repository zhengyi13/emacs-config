;;; autocomplete.el --- Autocomplete and minibuffer configuration module

;;; Commentary:
;; Vertico, orderless, marginalia, consult, corfu

;;; Code:

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init (savehist-mode))

;; present buffer options vertically
(use-package vertico
  :init
  (vertico-mode)
  (setq vertico-cycle t))

;; when sorting, fuzzy search
(use-package orderless
  :init
  (setq completion-styles '(orderless)
        completion-category-defaults nil
	orderless-matching-styles '(orderless-flex) ;; fuzzy-find style
        completion-category-overrides '((file (styles partial-completion)))))

;; Decorate stuff
(use-package marginalia
  :init (marginalia-mode))

;; iconify file/buffer completion
(use-package nerd-icons-completion
  :after marginalia
  :config
  (nerd-icons-completion-mode)
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))

(defun jbm/corfu-setup-lsp ()
  "Use orderless completion style with lsp-capf instead of the default lsp-passthrough."
  (setf (alist-get 'styles (alist-get 'lsp-capf completion-category-defaults))
        '(orderless)))

;; "COmpletion in Region FUnction" - completion popups in buffers (Vertico for minibuffer)
(use-package corfu
  :straight (corfu :files (:defaults "extensions/")
		   :includes (corfu-info corfu-history))
  :hook (lsp-completion-mode . jbm/corfu-setup-lsp) ; Use corfu for lsp completion
  :custom (corfu-auto t)
  :config (setq corfu-popupinfo-delay 0)
  :init
  (global-corfu-mode)
  (corfu-popupinfo-mode)
  :general (
	    :keymaps 'corfu-map
		     "C-n" #'corfu-next
		     "C-p" #'corfu-previous
		     "<escape>" #'corfu-quit
		     "<return>" #'corfu-insert
		     "H-SPC" #'corfu-insert-separator
		     "M-d" #'corfu-show-documentation
		     "C-g" #'corfu-quit
		     "M-l" #'corfu-show-location))

;; iconify the in-buffer completions
(use-package nerd-icons-corfu
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

;; Corfu uses child frames to display candidates. This makes Corfu
;; unusable on terminal. This package replaces that with popup/popon,
;; which works everywhere.
(use-package corfu-terminal
  :init (corfu-terminal-mode))

;; Over-ride a large pile of baseline functionality with better
;; versions (e.g. buffer switching with live previews) from Consult ()
;; Slightly slimmed down configuration for Consult from the docs
(use-package consult
  :bind (;; C-c bindings (mode-specific-map)
         ("C-c M-x" . consult-mode-command)
         ("C-c h" . consult-history)
         ("C-c k" . consult-kmacro)
         ("C-c m" . consult-man)
         ("C-c i" . consult-info)
         ([remap Info-search] . consult-info)
         ;; C-x bindings (ctl-x-map)
         ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
         ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
         ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
         ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
         ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
         ("C-x p b" . consult-project-buffer)      ;; orig. project-switch-to-buffer
         ;; Custom M-# bindings for fast register access
         ("M-#" . consult-register-load)
         ("M-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
         ("C-M-#" . consult-register)
         ;; Other custom bindings
         ("M-y" . consult-yank-pop)                ;; orig. yank-pop
         ;; M-g bindings (goto-map)
         ("M-g e" . consult-compile-error)
         ("M-g f" . consult-flymake)               ;; Alternative: consult-flycheck
         ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ;; M-s bindings (search-map)
         ("M-s d" . consult-find)
         ("M-s D" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         :map minibuffer-local-map
         ("M-s" . consult-history)                 ;; orig. next-matching-history-element
         ("M-r" . consult-history))                ;; orig. previous-matching-history-element

  ;; Enable automatic preview at point in the *Completions* buffer. This is
  ;; relevant when you use the default completion UI.
  :hook (completion-list-mode . consult-preview-at-point-mode)

  ;; The :init configuration is always executed (Not lazy)
  :init
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)
  (advice-add #'register-preview :override #'consult-register-window)

  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  ;; Configure other variables and modes in the :config section,
  ;; after lazily loading the package.
  :config
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   :preview-key '(:debounce 0.4 any))
  (setq consult-narrow-key "<"))

(use-package consult-lsp
  :bind (
	 ("C-c l s" . consult-lsp-symbols)
	 ("C-c l d" . consult-lsp-diagnostics)))

;; Arbitrary actions on arbitrary objects in buffers
(use-package embark
  :bind
  (("M-." . embark-act)         ;; pick some comfortable binding
;;   ("M-." . embark-dwim)
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'

  :init
  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)
  ;; Show the Embark target at point via Eldoc.  You may adjust the Eldoc
  ;; strategy, if you want to see the documentation from multiple providers.
  (add-hook 'eldoc-documentation-functions #'embark-eldoc-first-target)
  ;; (setq eldoc-documentation-strategy #'eldoc-documentation-compose-eagerly)
  :config
  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("`\*Embark Collect \(Live\|Completions\)\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

(use-package embark-consult
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(provide 'autocomplete-config-module)
;;; autocomplete.el ends here
