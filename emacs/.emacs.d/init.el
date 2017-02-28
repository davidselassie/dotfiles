(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
(setq vc-follow-symlinks t)

(require 'package)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
(setq use-package-always-ensure t)

(setq-default word-wrap t)
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

(setq mouse-wheel-progressive-speed 1)
(setq mouse-wheel-scroll-amount '(1))

(use-package exec-path-from-shell
  :config
  (when (memq window-system '(mac ns))
    (exec-path-from-shell-initialize)))

(global-hl-line-mode 1)
(menu-bar-mode 0)
(tool-bar-mode 0)
(use-package rainbow-delimiters
  :config
  (add-hook 'prog-mode-hook
            #'rainbow-delimiters-mode))
(show-paren-mode 1)
(setq-default show-paren-delay 0)
(use-package color-theme-sanityinc-solarized
  :config
  (load-theme 'solarized-light t)
  (set-face-attribute 'default nil :height 100))

(use-package ensime)
(use-package company)
(use-package paredit
  :config
  (add-hook 'emacs-lisp-mode-hook #'enable-paredit-mode))
(use-package magit)

(use-package git-gutter
  :config
  (global-git-gutter-mode t)
  (git-gutter:linum-setup))
(global-linum-mode 1)
(setq line-number-mode nil)
(setq column-number-mode t)

(use-package markdown-mode)

(add-hook 'term-mode-hook
 (lambda ()
   (setq yas-dont-activate t)))
(add-hook 'before-save-hook
 'delete-trailing-whitespace)

(defun message-buffer-file-name ()
  "Display the full path to the current buffer's file."
  (interactive)
  (message (buffer-file-name (window-buffer (minibuffer-selected-window)))))
(global-set-key (kbd "C-x C-p") 'message-buffer-file-name)

(setq-default ispell-program-name "hunspell")
;(setq-default ispell-really-hunspell t)

(server-start)
