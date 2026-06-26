# emacs

[![Test](https://github.com/bsamek/emacs/actions/workflows/test.yml/badge.svg)](https://github.com/bsamek/emacs/actions/workflows/test.yml)

## Overview

My personal Emacs configuration is centered on a single `init.el` that is meant
to be easy to install, inspect, and keep working on a fresh machine. It uses
built-in Emacs features where they fit, with `use-package` managing the rest of
the package setup.

The config is oriented around a Vim-like editing workflow with Evil,
Evil Collection, Which Key, and a `SPC` leader-key menu built with General. It
also includes a modern completion and navigation stack: Vertico, Marginalia,
Orderless, Consult, Embark, Corfu, Cape, Avy, Project, Flymake, and Eglot.

Language and writing support currently covers Org, Markdown, and Go. Org mode
gets custom return, tab, and backtab behavior for fast outline and list editing;
Markdown gets visual wrapping and GitHub-flavored README editing; Go buffers
start Eglot automatically.

## GitHub Actions

The GitHub Actions workflow boots the config on both macOS and Ubuntu with a
temporary home directory, checks first-run package bootstrap, then verifies a
steady-state startup without warnings or errors.

## Packages

- `package`: Configures Emacs package archives, adds MELPA, and initializes package management.
- `gnu-elpa-keyring-update`: Keeps GNU ELPA signing keys current before dependency installation.
- `use-package`: Declares package setup in a compact form and is configured to ensure packages are installed by default.
- `server`: Starts an Emacs server in graphical sessions so `emacsclient` can reuse the GUI instance.
- `exec-path-from-shell`: Imports the shell `PATH` into macOS GUI Emacs, pinned to MELPA and only enabled on macOS/NS window systems.
- `evil`: Provides Vim-style modal editing, with `C-u` restored for half-page scrolling.
- `evil-collection`: Extends Evil keybindings across built-in and package modes after Evil loads.
- `which-key`: Shows available keybindings after prefix keys such as `SPC`.
- `general`: Defines the `SPC` leader-key menu through the custom `my/leader` definer for normal and visual Evil states.
- `project`: Adds built-in project navigation commands under `SPC p`.
- `flymake`: Adds built-in diagnostics commands under `SPC d`.
- `eglot`: Adds built-in LSP commands under `SPC d`, including start, rename, code actions, and format.
- `avy`: Provides fast visible-text jumping under `SPC j` and enables Avy's default setup.
- `vertico`: Replaces the default minibuffer completion display with a vertical completion UI.
- `marginalia`: Adds annotations to minibuffer completion candidates.
- `orderless`: Enables space-separated fuzzy matching while preserving partial completion for files.
- `recentf`: Tracks recently opened files for `consult-recent-file`.
- `embark-consult`: Connects Embark collection buffers to Consult previews and is declared before Consult loads to avoid first-run warnings.
- `consult`: Provides enhanced search and navigation commands under `SPC f`, `SPC s`, and `SPC g`.
- `embark`: Adds context actions for minibuffer candidates and text at point on `C-.` and `C-;`.
- `corfu`: Enables in-buffer completion popups globally with automatic completion after a short delay.
- `cape`: Adds file, dabbrev, and keyword completion-at-point sources and exposes them under `SPC c`.
- `org`: Configures Org notes, outlines, and tasks with visual wrapping, indentation, compact stars, custom `RET`/`TAB`/`backtab` behavior, Evil bindings, and `SPC o` commands.
- `visual-fill-column`: Soft-wraps Markdown buffers at a fixed width of 100 columns without centering text.
- `markdown-mode`: Enables Markdown and GitHub-flavored README editing with visual line wrapping.
- `go-mode`: Enables Go editing and starts Eglot automatically in Go buffers.
- `doom-themes`: Loads the `doom-oceanic-next` theme.
- `xclip`: Enables clipboard integration on systems where the `xclip` executable is available.
