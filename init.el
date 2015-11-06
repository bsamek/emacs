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


;; packages
(use-package ido
  :config
  (ido-mode 1))

(use-package powerline
  :config
  (powerline-default-theme))


;; ui
(load-theme 'leuven)
