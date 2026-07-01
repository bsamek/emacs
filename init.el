;; Package archives
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Keep Customize-generated settings out of this version-controlled init file.
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; Keep GNU ELPA signing keys current before packages install dependencies.
(unless (package-installed-p 'gnu-elpa-keyring-update)
  (unless package-archive-contents
    (package-refresh-contents))
  (package-install 'gnu-elpa-keyring-update))

;; Minimal UI chrome
(menu-bar-mode -1)
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

(dolist (frame-param '(menu-bar-lines tool-bar-lines vertical-scroll-bars))
  (setq default-frame-alist (assq-delete-all frame-param default-frame-alist))
  (setq initial-frame-alist (assq-delete-all frame-param initial-frame-alist)))
(add-to-list 'default-frame-alist '(menu-bar-lines . 0))
(add-to-list 'default-frame-alist '(tool-bar-lines . 0))
(add-to-list 'default-frame-alist '(vertical-scroll-bars . nil))
(add-to-list 'initial-frame-alist '(menu-bar-lines . 0))
(add-to-list 'initial-frame-alist '(tool-bar-lines . 0))
(add-to-list 'initial-frame-alist '(vertical-scroll-bars . nil))

;; use-package (built in since Emacs 29)
(require 'use-package)
(setq use-package-always-ensure t)

;; Follow version-controlled symlinks without prompting.
(setq vc-follow-symlinks t)

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

;; Recentf — track recently opened files for consult-recent-file
(use-package recentf
  :ensure nil
  :init
  (recentf-mode 1))

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

;; Org — notes, outlines, tasks
(use-package org
  :ensure nil
  :mode ("\\.org\\'" . org-mode)
  :hook ((org-mode . visual-line-mode)
         (org-mode . org-indent-mode))
  :custom
  (org-directory (expand-file-name "~/org/"))
  (org-default-notes-file (expand-file-name "inbox.org" org-directory))
  (org-agenda-files (list org-directory))
  (org-startup-indented t)
  (org-hide-leading-stars t)
  (org-ellipsis "...")
  (org-adapt-indentation nil)
  (org-return-follows-link t)
  :config
  (defun my/org-return-dwim ()
    "Continue Org headings and lists when pressing RET."
    (interactive)
    (cond
     ((org-at-heading-p)
      (org-insert-heading-respect-content))
     ((org-in-item-p)
      (org-insert-item))
     (t
      (org-return-and-maybe-indent))))

  (defun my/org-tab-dwim ()
    "Indent Org headings and list items, otherwise cycle visibility."
    (interactive)
    (if (or (org-at-heading-p) (org-in-item-p))
        (org-metaright)
      (org-cycle)))

  (defun my/org-backtab-dwim ()
    "Outdent Org headings and list items, otherwise cycle globally."
    (interactive)
    (if (or (org-at-heading-p) (org-in-item-p))
        (org-metaleft)
      (org-shifttab)))

  (define-key org-mode-map (kbd "RET") #'my/org-return-dwim)
  (define-key org-mode-map (kbd "TAB") #'my/org-tab-dwim)
  (define-key org-mode-map (kbd "<backtab>") #'my/org-backtab-dwim)

  (with-eval-after-load 'evil
    (evil-define-key '(normal insert) org-mode-map
      (kbd "RET") #'my/org-return-dwim
      (kbd "TAB") #'my/org-tab-dwim
      (kbd "<backtab>") #'my/org-backtab-dwim))

  (my/leader
    "o"  '(:ignore t :which-key "org")
    "oa" '(org-agenda :which-key "agenda")
    "oc" '(org-capture :which-key "capture")
    "of" '((lambda () (interactive) (find-file org-directory)) :which-key "org directory")
    "ot" '(org-todo :which-key "todo")))

;; visual-fill-column — soft-wrap text at a fixed column.
(use-package visual-fill-column
  :hook (markdown-mode . visual-fill-column-mode)
  :custom
  (visual-fill-column-width 100)
  (visual-fill-column-center-text nil))

;; Markdown — Markdown editing mode
(use-package markdown-mode
  :mode (("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode)
         ("README\\.md\\'" . gfm-mode))
  :hook (markdown-mode . visual-line-mode))

;; Go — Go editing mode
(use-package go-mode
  :mode "\\.go\\'"
  :hook (go-mode . eglot-ensure))

(use-package doom-themes
  :config
  (load-theme 'doom-oceanic-next t))

(use-package xclip
  :ensure t
  :config
  (when (executable-find "xclip")
    (xclip-mode 1)))
