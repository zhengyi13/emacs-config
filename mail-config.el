;; Mail

(use-package mu4e
  :ensure nil
  :load-path "/usr/share/emacs/site-lisp/mu4e/"
  :config
  (setq mu4e-update-interval (* 10 60))
  (setq user-mail-address "zhengyi13@gmail.com")
  (setq mu4e-maildir "~/Maildir")
  (setq mu4e-drafts-folder "/Drafts")
  (setq mu4e-sent-folder "/Sent Mail")
  (setq mu4e-refile-folder "/All Mail")
  (setq mu4e-trash-folder "/Trash")
  (setq mu4e-maildir-shortcuts
	'(("/INBOX"    . ?i)
	  ("/All Mail" . ?a))))

(use-package notmuch
  :init
  (setq message-directory "~/Maildir")
  (setq send-mail-function 'sendmail-send-it)
  ;; Send from correct email account
  (setq message-sendmail-f-is-evil 't)
  (setq message-sendmail-extra-arguments '("--read-envelope-from"))
  (setq mail-specify-envelope-from 't)
  (setq mail-envelope-from 'header)
  (setq message-sendmail-envelope-from 'header)
  ;; Setting proper from, fixes i-did-not-set--mail-host-address--so-tickle-me
  (setq mail-host-address "gmail.com")
  (setq user-full-name "Justin Meyer")
  :config
  (setq notmuch-show-logo nil)
  ;; Writing email
  (setq message-default-mail-headers "Cc: \nBcc: \n") ;; Always show BCC
  (setq notmuch-always-prompt-for-sender 't))

(provide 'mail-config)
