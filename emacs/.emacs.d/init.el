(server-start)

(defvar autosave-dir "~/.emacs.d/auto-save-files/")
(defvar backup-dir "~/.emacs.d/backup-files/")

(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/"))
(package-initialize)
(eval-when-compile
  (require 'use-package))
(setq use-package-always-ensure t)

(use-package ensime)
(use-package company)
(use-package paredit)

(add-hook
 'term-mode-hook
 (lambda ()
   (setq yas-dont-activate t)))

(setq-default ispell-program-name "hunspell")
;(setq-default ispell-really-hunspell t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(before-save-hook (quote (delete-trailing-whitespace)))
 '(custom-safe-themes
   (quote
	("a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" default)))
 '(global-hl-line-mode t)
 '(mouse-wheel-progressive-speed nil)
 '(mouse-wheel-scroll-amount (quote (1)))
 '(package-selected-packages
   (quote
	(solarized-theme paredit magit undo-tree ensime scala-mode use-package)))
 '(tab-width 4)
 '(vc-follow-symlinks t)
 '(word-wrap t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
