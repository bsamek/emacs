(require 'cl)

;;; The GUI

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




;;; Set up use-package

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(unless package-archive-contents (package-refresh-contents))
(package-initialize)
(unless (package-installed-p 'use-package) (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)




;;; Packages

(use-package ace-jump-mode
  :bind ("C-c SPC" . ace-jump-mode))

(use-package auto-complete
  :diminish auto-complete-mode
  :init (ac-config-default))

(use-package diminish)

(use-package evil
  :config (evil-mode 1)
  :diminish undo-tree-mode)

(use-package evil-surround
  :config (global-evil-surround-mode 1))

(use-package ido
  :config (ido-mode 1))

(use-package magit
  :bind ("C-x g" . magit-status))

(use-package paredit
  :diminish paredit-mode
  :config
  (add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
  (add-hook 'lisp-mode-hook 'enable-paredit-mode))

(use-package powerline
 :config (powerline-center-evil-theme))

(use-package slime
  :init (setq slime-lisp-implementations
                    (case system-type
				  ('gnu/linux '((sbcl  ("/usr/local/bin/sbcl"))))
				  ('darwin '((sbcl  ("/usr/local/bin/sbcl"))))
				  ('windows-nt '((sbcl ("\\Program Files\\Steel Bank Common Lisp\\1.3.0\\sbcl.exe")))))))

(use-package smex
  :bind ("M-x" . smex))

(use-package solarized-theme
  :config (load-theme 'solarized-dark t))

(use-package undo-tree
  :config (global-undo-tree-mode)
  :diminish undo-tree-mode)

(use-package winner
  :init (winner-mode 1))
