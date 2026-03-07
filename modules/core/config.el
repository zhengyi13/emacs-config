;; Basic, general settings
(use-package emacs
  :custom
  (setq inhibit-startup-message t)
  (scroll-bar-mode -1)        ; Disable visible scrollbar
  (tool-bar-mode -1)          ; Disable the toolbar
  (tooltip-mode -1)           ; Disable tooltips
  (set-fringe-mode 10)        ; Give some breathing room
  (menu-bar-mode -1)            ; Disable the menu bar

  ;; Enable line numbers generally, except for...
  (column-number-mode)
  (global-display-line-numbers-mode t) 
  (dolist (mode '(org-mode-hook
                  term-mode-hook
                  shell-mode-hook
                  treemacs-mode-hook
                  eshell-mode-hook))
    (add-hook mode (lambda () (display-line-numbers-mode 0))))
  ;; Set this to prevent the Warnings buffer from always popping up,
  ;; because I'm fucking sick of complaints about random style
  ;; violations
  (setq native-comp-async-report-warnings-errors "silent")
  ;; Always use short form answers
  (defalias 'yes-or-no-p 'y-or-n-p))

;; The whole point of this little definition and remapping is to later
;; enable remapping the supremely convenient M-m to be a generic
;; prefix key for other maps (think general.el)
(defun smart-beginning-of-line ()
  "Move point to first non-whitespace character or beginning-of-line.

Move point to the first non-whitespace character on this line.
If point was already at that position, move point to beginning of line."
  (interactive)
  (let ((oldpos (point)))
    (back-to-indentation)
    (and (= oldpos (point))
         (beginning-of-line))))

(global-set-key [home] 'smart-beginning-of-line)
(global-set-key "\C-a" 'smart-beginning-of-line)

(provide 'core-config)
