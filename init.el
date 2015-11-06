;; melpa
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(unless package-archive-contents (package-refresh-contents))
(package-initialize)


;; use-package
(unless (package-installed-p 'use-package) (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)


;; gui
(setq inhibit-startup-screen t)
(tool-bar-mode -1)
      
;; packages
(use-package diminish)

(use-package ido
  :config (ido-mode 1))

(use-package powerline
  :config (powerline-default-theme))

(use-package auto-complete
  :diminish auto-complete-mode
  :init (ac-config-default))

(use-package solarized-theme
  :config (load-theme 'solarized-dark t))
