;; If we're ever running on WSL specifically, we can reach into the
;; outer Windows system, and pop a browser there to see any URLs we
;; encounter here in emacs.

(when (and (eq system-type 'gnu/linux)               ;; if you really think this is GNU/Linux
           (getenv "WSLENV"))                        ;; ... but you also see this variable defined, well then:
  (let ((cmd-exe "/mnt/c/Windows/System32/cmd.exe")  ;; ... define a shell wrapper
        (cmd-args '("/c" "start")))
    (when (file-exists-p cmd-exe)                    ;; ... validate that it exists
      (setq browse-url-generic-program  cmd-exe      ;; ... and use it everywhere
            browse-url-generic-args     cmd-args
            browse-url-browser-function 'browse-url-generic
            search-web-default-browser 'browse-url-generic))))

(provide 'core-wsl)
