;; David Selassie
;; Emacs init.el

(require 'package)
(package-initialize)
(add-to-list 'package-archives
 '("marmalade" . "http://marmalade-repo.org/packages/") t)

(setq-default make-backup-files nil)

(setq-default menu-bar-mode 0)
(setq-default inhibit-startup-message t)
(setq-default vc-follow-symlinks t)
(setq-default read-file-name-completion-ignore-case t)

(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

(defun insert-tab ()
  (interactive)
  (insert "\t"))
(global-set-key [backtab] 'insert-tab)

(global-set-key [kp-delete] 'delete-char)
(global-set-key [home] 'beginning-of-line)
(global-set-key [end] 'end-of-line)
;; For some curious reason, OS X Terminal ouputs <select> for END.
(global-set-key [select] 'end-of-line)

;; Don't let me use the arrow keys.
(global-unset-key [up])
(global-unset-key [down])
(global-unset-key [left])
(global-unset-key [right])

(global-unset-key (kbd "M-g"))
(global-set-key (kbd "M-g M-g") 'goto-line)
(global-set-key (kbd "C-c C-c") 'comment-region)
(global-unset-key (kbd "M-_"))
(global-set-key (kbd "C--") 'undo)

(defun kill-line-save ()
  (interactive)
  (set-mark-command nil)
  (move-end-of-line nil)
  (kill-ring-save (region-beginning) (region-end))
  (exchange-point-and-mark))
(defun kill-whole-line ()
  (interactive)
  (move-beginning-of-line nil)
  (kill-line))
(defun kill-whole-line-save ()
  (interacive)
  (move-beginning-of-line nil)
  (duplicate-line))
(global-set-key (kbd "C-k") 'kill-line)
(global-set-key (kbd "M-k") 'kill-line-save)

(defun scroll-down-keep-cursor ()
  (interactive)
  (scroll-down 1))
(defun scroll-up-keep-cursor ()
  (interactive)
  (scroll-up 1))
(global-set-key (kbd "M-p") 'scroll-down-keep-cursor)
(global-set-key (kbd "M-n") 'scroll-up-keep-cursor)

(global-hl-line-mode t)
(setq-default show-trailing-whitespace t)
(setq-default fill-column 80)
(setq-default whitespace-line-column nil)

(global-linum-mode t)
(set-face-background 'hl-line "bright black")
(set-face-background 'region "bright black")
(setq-default linum-format (format "%%03d%c" ?\x200B))
(setq-default column-number-mode t)
(setq-default line-number-mode t)

(transient-mark-mode t)

(global-font-lock-mode t)
(global-whitespace-mode t)
(defun terminal-init-screen ()
  "Terminal initialization function for screen-256color."
  (load "term/xterm")
  (xterm-register-default-colors)
  (tty-set-up-initial-frame-faces))

(setq-default whitespace-style
              '(face
                trailing
                space-mark
                tab-mark))

(require 'mouse)
(defun terminal-config (&optional frame)
  (xterm-mouse-mode t))
(add-hook 'after-make-frame-functions 'terminal-config)
(setq-default mouse-select-mode t)
(defun track-mouse (e))
(global-set-key [mouse-4] 'scroll-down-keep-cursor)
(global-set-key [mouse-5] 'scroll-up-keep-cursor)

(if (file-exists-p "~/.emacslocalinit.el") (load-file "~/.emacslocalinit.el"))
