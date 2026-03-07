;; My emacs config

;; Fundamentally, bootstrap straight.el for use w/ use-package, so
;; dependency versions could be frozen, if I ever *really* cared about
;; portability.
(defvar bootstrap-version)
(setq warning-minimum-level :emergency)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; These two together let me use use-package, *and* not require a :straight t per stanza
(setq straight-use-package-by-default t)
(straight-use-package 'use-package)

;; load core loader
(let ((core-loader (expand-file-name "modules/core/core.el" user-emacs-directory)))
  (when (file-exists-p core-loader)
    (load core-loader nil 'nomessage)))

;; load locally-modularized files
(add-to-list 'load-path "/home/zhengyi/dotfiles/.emacs.d")
(require 'main-config)          ;; Main: basic settings like scrollbars, etc...
(require 'keybindings-config)   ;; TODO: make this do more than load general.el
(require 'ui-config)            ;; UI: Appearance and Ergonomics (which-key, avy, ace-jump)
;;(require 'mail-config)          ;; setup mu4e, notmuch

;; Modularized features
(jbm/load-module 'completion 'autocomplete)
(jbm/load-module 'lsp 'lsp)
(jbm/load-module 'git 'git)
(jbm/load-module 'ui 'fzf)
(jbm/load-module 'lang 'go)
(jbm/load-module 'lang 'python)
(jbm/load-module 'lang 'lua)
(jbm/load-module 'lang 'yaml)
(jbm/load-module 'lang 'terraform)

(require 'miscellaneous-config) ;; All the stuff that's not otherwise obviously for elsewhere
(require 'org-roam-config)      ;; Org and Org-Roam
;; (require 'wsl-config)           ;; WSL-relevant config

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(elfeed-feeds
   '("https://xeiaso.net/blog.rss" "https://kubernetespodcast.com/feeds/audio.xml" "https://www.phoronix.com/phoronix-rss.php" "https://daniel.haxx.se/blog/feed/" "https://rachelbythebay.com/w/atom.xml" "https://hackaday.com/blog/feed" "https://lwn.net/headlines/newrss" "https://drewdevault.com/blog/index.xml" "https://blog.alexellis.io/rss/" "https://www.cncf.io/feed/" "https://planet.emacslife.com/atom.xml" "https://thenewstack.io/blog/feed/" "https://kubernetes.io/feed.xml"))
 '(org-babel-load-languages '((shell . t))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
