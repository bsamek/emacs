(require 'cl)


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

(use-package anzu
  :diminish anzu-mode
  :config (global-anzu-mode 1))

(use-package auto-complete
  :diminish auto-complete-mode
  :init (ac-config-default))

(use-package browse-kill-ring
  :bind ("C-c k" . browse-kill-ring))

(use-package diminish)

(use-package evil
  :config
  (evil-mode 1)
  :diminish undo-tree-mode)

(use-package evil-leader
  :config
  (global-evil-leader-mode)
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key
    "<SPC>" 'ace-jump-mode
    "0" 'select-window-0
    "1" 'select-window-1
    "2" 'select-window-2
    "3" 'select-window-3
    "4" 'select-window-4
    "5" 'select-window-5
    "6" 'select-window-6
    "7" 'select-window-7
    "8" 'select-window-8
    "9" 'select-window-9
    "ad" 'dired
    "as" 'shell
    "bb" 'switch-to-buffer
    "br" 'rename-buffer
    "bs" 'save-buffer
    "cc" 'flycheck-buffer
    "cf" 'flycheck-mode
    "cn" 'flycheck-next-error
    "cp" 'flycheck-previous-error
    "cs" 'flycheck-select-checker
    "cv" 'flycheck-verify-setup
    "ff" 'find-file
    "g" 'magit-status
    "hb" 'describe-bindings
    "hf" 'describe-function
    "hi" 'info
    "hk" 'describe-key
    "hv" 'describe-variable
    "i" 'indent-region
    "k" 'browse-kill-ring
    "o" 'other-window
    "p" 'projectile-command-map
    "sg" 'rgrep
    "so" 'occur
    "tf" 'toggle-frame-fullscreen
    "tm" 'toggle-frame-maximized
    "tr" 'rainbow-delimiters-mode
    "tt" 'helm-themes
    "u" 'undo-tree-visualize
    "x" 'execute-extended-command
    "z" 'evil-emacs-state)) 


(use-package evil-surround
  :config (global-evil-surround-mode 1))

(use-package exec-path-from-shell
  :config
  (when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize)))

(use-package flycheck
  :config (global-flycheck-mode 1)
  :diminish flycheck-mode)

(use-package go-mode)

(use-package golden-ratio
  :config
  (golden-ratio-mode 1)
  (setq golden-ratio-extra-commands
	(append golden-ratio-extra-commands
		'(evil-window-left
		  evil-window-right
		  evil-window-up
		  evil-window-down
		  select-window-1
		  select-window-2
		  select-window-3
		  select-window-4
		  select-window-5
		  select-window-6
		  select-window-7
		  select-window-8
		  select-window-9)))
  :diminish golden-ratio-mode)

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
  (key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
  (key-chord-mode 1))

(use-package magit
  :bind ("C-c g" . magit-status))

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

(use-package rainbow-delimiters)

(use-package undo-tree
  :config (global-undo-tree-mode)
  :diminish undo-tree-mode)

(use-package window-numbering
  :config (window-numbering-mode 1))
  
(use-package winner
  :init (winner-mode 1))

(use-package yaml-mode)

(use-package yasnippet
  :config (yas-global-mode 1)
  :diminish yas-minor-mode)


;;; Appearance
(use-package helm-themes)
(use-package sublime-themes)
(use-package solarized-theme)
(use-package monokai-theme)
(load-theme 'monokai t)
(setq inhibit-startup-screen t)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(set-face-attribute 'default nil
                    :family (case system-type
				  ('gnu/linux "Inconsolata")
				  ('darwin "Menlo")
				  ('windows-nt "Consolas"))
		    :height (case system-type
				  ('gnu/linux 120)
				  ('darwin 140)
				  ('windows-nt 110)))
