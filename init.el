;; Set up MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(unless package-archive-contents (package-refresh-contents))
(package-initialize)

;; Install use-package if it's not present
(unless (package-installed-p 'use-package) (package-install 'use-package))
(require 'use-package)

