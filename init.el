;; Package archives
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Keep GNU ELPA signing keys current before packages install dependencies.
(unless (package-installed-p 'gnu-elpa-keyring-update)
  (unless package-archive-contents
    (package-refresh-contents))
  (package-install 'gnu-elpa-keyring-update))

;; Minimal GUI chrome
(when (display-graphic-p)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (menu-bar-mode -1))

(add-to-list 'default-frame-alist '(tool-bar-lines . 0))
(add-to-list 'default-frame-alist '(vertical-scroll-bars . nil))
(add-to-list 'default-frame-alist '(menu-bar-lines . 0))

;; use-package (built in since Emacs 29)
(require 'use-package)
(setq use-package-always-ensure t)

;; Let emacsclient reuse the GUI Emacs session.
(use-package server
  :ensure nil
  :if (display-graphic-p)
  :config
  (unless (server-running-p)
    (server-start)))

;; macOS GUI apps do not inherit the shell PATH by default.
(when (memq window-system '(mac ns))
  (use-package exec-path-from-shell
    :pin melpa
    :config
    (exec-path-from-shell-initialize)))

;; macOS: use Option as Meta
(setq mac-option-modifier 'meta)

;; Isearch — built-in match counts
(setq isearch-lazy-count t)

;; Must be set before evil or evil-collection load.
(setq evil-want-keybinding nil)

;; Evil — Vim emulation
(use-package evil
  :init
  (setq evil-want-C-u-scroll t)    ;; restore C-u for half-page scroll
  :config
  (evil-mode 1))

;; Evil-collection — Vim keybindings across Emacs (dired, magit, etc.)
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; which-key — popup showing available keys after a prefix
(use-package which-key
  :init (which-key-mode 1))

;; general — declarative leader-key bindings
(use-package general
  :after evil
  :config
  (general-create-definer my/leader
    :states '(normal visual)
    :keymaps 'override
    :prefix "SPC")

  (my/leader
    "SPC" '(execute-extended-command :which-key "M-x")
    "f"  '(:ignore t :which-key "files")
    "ff" '(find-file :which-key "find file")
    "fs" '(save-buffer :which-key "save")
    "b"  '(:ignore t :which-key "buffers")
    "bb" '(consult-buffer :which-key "switch")
    "bk" '(kill-buffer :which-key "kill")
    "w"  '(evil-window-map :which-key "window")))

;; Project — built-in project navigation
(use-package project
  :ensure nil
  :after general
  :config
  (my/leader
    "p"  '(:ignore t :which-key "project")
    "pb" '(project-switch-to-buffer :which-key "buffer")
    "pf" '(project-find-file :which-key "find file")
    "pk" '(project-kill-buffers :which-key "kill buffers")
    "pp" '(project-switch-project :which-key "switch")
    "ps" '(project-shell-command :which-key "shell command")))

;; Flymake — built-in diagnostics
(use-package flymake
  :ensure nil
  :after general
  :config
  (my/leader
    "d"  '(:ignore t :which-key "diagnostics")
    "dd" '(flymake-show-buffer-diagnostics :which-key "buffer diagnostics")
    "dp" '(flymake-show-project-diagnostics :which-key "project diagnostics")
    "dn" '(flymake-goto-next-error :which-key "next diagnostic")
    "dN" '(flymake-goto-prev-error :which-key "previous diagnostic")))

;; Eglot — built-in LSP client
(use-package eglot
  :ensure nil
  :after general
  :config
  (my/leader
    "dl" '(eglot :which-key "start LSP")
    "dr" '(eglot-rename :which-key "rename")
    "da" '(eglot-code-actions :which-key "code actions")
    "df" '(eglot-format :which-key "format")))

;; Avy — fast visible-text jumping
(use-package avy
  :after general
  :config
  (avy-setup-default)

  (my/leader
    "j"  '(:ignore t :which-key "jump")
    "jj" '(avy-goto-char-timer :which-key "jump by text")
    "jc" '(avy-goto-char-2 :which-key "jump to chars")
    "jl" '(avy-goto-line :which-key "jump to line")
    "jw" '(avy-goto-word-1 :which-key "jump to word")
    "jr" '(avy-resume :which-key "resume jump")))

;; Vertico — vertical completion UI
(use-package vertico
  :init (vertico-mode 1))

;; Marginalia — annotations in the minibuffer
(use-package marginalia
  :init (marginalia-mode 1))

;; Orderless — fuzzy / space-separated matching
(use-package orderless
  :init
  (setq completion-styles '(orderless basic)
        completion-category-overrides '((file (styles partial-completion)))))

;; Embark-consult — integration between Embark and Consult
;; Declared before Consult loads so first-run installs avoid Embark's warning.
(use-package embark-consult
  :after (embark consult)
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

;; Consult — enhanced search and navigation commands
(use-package consult
  :after general
  :config
  (my/leader
    "g"  '(:ignore t :which-key "goto")
    "fr" '(consult-recent-file :which-key "recent file")
    "s"  '(:ignore t :which-key "search")
    "sg" '(consult-ripgrep :which-key "ripgrep")
    "sl" '(consult-line :which-key "line")
    "si" '(consult-imenu :which-key "imenu")
    "gl" '(consult-goto-line :which-key "goto line")))

;; Embark — context actions for minibuffer candidates and text at point
(use-package embark
  :bind
  (("C-." . embark-act)
   ("C-;" . embark-dwim)))

;; Corfu — in-buffer completion popup
(use-package corfu
  :init
  (global-corfu-mode 1)
  :custom
  (corfu-auto t)
  (corfu-auto-delay 0.2)
  (corfu-auto-prefix 2))

;; Cape — completion-at-point extensions
(use-package cape
  :after general
  :init
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-keyword)
  :config
  (my/leader
    "c"  '(:ignore t :which-key "complete")
    "cf" '(cape-file :which-key "file")
    "cd" '(cape-dabbrev :which-key "dabbrev")
    "ck" '(cape-keyword :which-key "keyword")))

;; Markdown — Markdown editing mode
(use-package markdown-mode
  :mode (("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode)
         ("README\\.md\\'" . gfm-mode)))

;; Go — Go editing mode
(use-package go-mode
  :mode "\\.go\\'"
  :hook (go-mode . eglot-ensure))

(use-package doom-themes
  :config
  (load-theme 'doom-oceanic-next t))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("aec7b55f2a13307a55517fdf08438863d694550565dee23181d2ebd973ebd6b8"
     default))
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
