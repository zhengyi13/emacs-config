;; Org, Org-Roam (zettlekasten/note-taking) and friends

(use-package org
  :straight (:type built-in)
  :bind (
	 ("C-c o a" . org-agenda)
	 ("C-c o c" . org-capture)
	 ("C-c o i" . org-insert-structure-template))
  :config
  (setq org-agenda-files '("~/notes" "~/notes/daily" "~/.notes"))
  (add-hook 'org-mode-hook 'turn-on-auto-fill))

(use-package org-roam
  :after org
  :init
  :custom
  (org-roam-directory "~/notes")
  (org-roam-dailies-directory "daily/")
  (org-roam-completion-everywhere t)
  (org-return-follows-link t)
  (org-roam-dailies-capture-templates
     '(("d" "Journal" plain "* %? "
        :if-new (file+head+olp "%<%Y-%m-%d>.org"
			       "#+title: %<%Y-%m-%d>\n#+filetags: %<:%Y:%B:>\n"
			       ("Journal\n\n* Notes \n\n* Questions")))
       ("t" "TODOs" entry "\n* TODO %? :mit:"
        :if-new (file+head+olp "%<%Y-%m-%d>.org"
			       "#+title: %<%Y-%m-%d>\n#+filetags: %<:%Y:%B:todos:>\n"
			       ("TODOs")))))
  :bind
  ("C-c o d" . org-roam-dailies-goto-today)
  ("C-c n l" . org-roam-buffer-toggle)
  ("C-c n f" . org-roam-node-find)
  (:map org-mode-map
        (("C-c n i" . org-roam-node-insert)
         ("C-c n o" . org-id-get-create)
	 ("M-o" . org-mark-ring-goto)
	 ("C-M-i" . completion-at-point)
         ("C-c n t" . org-roam-tag-add)
         ("C-c n a" . org-roam-alias-add)
         ("C-c n l" . org-roam-buffer-toggle)))
  :config
  (org-roam-setup)
  (org-roam-db-autosync-mode))

(use-package org-roam-ui
  :straight
    (:host github :repo "org-roam/org-roam-ui" :branch "main" :files ("*.el" "out"))
    :after org-roam
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))

(provide 'org-roam-config)
