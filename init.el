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
(use-package ace-jump-mode)

(use-package auto-complete
  :diminish auto-complete-mode
  :init (ac-config-default))

(use-package diminish)

(use-package evil
  :config
  (evil-mode 1)
  (define-key evil-normal-state-map (kbd "SPC") 'ace-jump-mode)
  :diminish undo-tree-mode)

(use-package evil-surround
  :config (global-evil-surround-mode 1))

(use-package exec-path-from-shell
  :config
  (when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize)))

(use-package go-mode)

(use-package guide-key
  :diminish guide-key-mode
  :config
  (guide-key-mode 1)
  (setq guide-key/guide-key-sequence t))

(use-package helm
  :diminish helm-mode
  :config (helm-mode 1))

(use-package helm-projectile)

(use-package key-chord
  :config
  (setq key-chord-one-key-delay .2)
  (key-chord-define evil-insert-state-map "jj" 'evil-normal-state)
  (key-chord-mode 1))

;; (use-package ido
;;   :config
;;   (ido-mode 1)
;;   (ido-everywhere 1))

;; (use-package ido-ubiquitous
;;   :config (ido-ubiquitous-mode 1))

(use-package magit
  :bind ("C-x g" . magit-status))

(use-package markdown-mode
  :mode
  (("\\.md\\'" . markdown-mode)
  ("\\.mdwn\\'" . markdown-mode)
  ("\\.markdown\\'" . markdown-mode)))

(use-package neotree)

(use-package powerline
 :config (powerline-center-evil-theme))

(use-package projectile
  :config
  (projectile-global-mode)
  (setq projectile-completion-system 'helm)
  (helm-projectile-on))

;; (use-package smex
;;   :bind ("M-x" . smex))

(use-package undo-tree
  :config (global-undo-tree-mode)
  :diminish undo-tree-mode)

(use-package winner
  :init (winner-mode 1))

(use-package yaml-mode)


;;; Themes
(use-package monokai-theme)
(use-package solarized-theme)
(load-theme 'monokai t)
