(require 'cl)


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
(scroll-bar-mode -1)
(set-face-attribute 'default nil
                    :family (case system-type
				  ('gnu/linux "Inconsolata")
				  ('darwin "Menlo")
				  ('windows-nt "Consolas"))
		    :height (case system-type
				  ('gnu/linux 130)
				  ('darwin 140)
				  ('windows-nt 110)))


;; packages
(use-package diminish)

(use-package ido
  :config (ido-mode 1))

(use-package powerline)
;;  :config (powerline-center-evil-theme))

(use-package auto-complete
  :diminish auto-complete-mode
  :init (ac-config-default))

(use-package solarized-theme
  :config (load-theme 'solarized-dark t))

(use-package magit
  :bind ("C-x g" . magit-status))

;; (use-package evil
;;   :config (evil-mode 1)
;;   :diminish undo-tree-mode)

(use-package god-mode
  :bind ("<escape>" . god-mode-all))

(use-package undo-tree
  :config (global-undo-tree-mode)
  :diminish undo-tree-mode)

(use-package slime
  :init (setq slime-lisp-implementations
                    (case system-type
				  ('gnu/linux '((sbcl  ("/usr/local/bin/sbcl"))))
				  ('darwin '((sbcl  ("/usr/local/bin/sbcl"))))
				  ('windows-nt '((sbcl ("\\Program Files\\Steel Bank Common Lisp\\1.3.0\\sbcl.exe")))))))

(use-package smex
  :bind ("M-x" . smex))

(use-package winner
  :init (winner-mode 1))

(use-package ace-jump-mode
  :bind ("C-." . ace-jump-mode))
