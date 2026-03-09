# Gemini Configuration for Emacs Config

## Module Naming
- Personal configuration modules in `modules/` must NEVER share the same name as upstream Emacs features or packages (e.g., use `roam-config.el` instead of `roam.el` if `(provide 'org-roam)` is expected from the package).
- Always use a `-config` suffix or a unique prefix for personal configuration files that wrap existing packages to avoid `eval-after-load` race conditions and symbol shadowing.
