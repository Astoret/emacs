(add-to-list 'load-path "~/.emacs.d/ergoemacs-mode")
(require 'ergoemacs-mode)
(setq ergoemacs-theme nil) ;; Uses Standard Ergoemacs keyboard theme
(setq ergoemacs-keyboard-layout "us") ;; Assumes QWERTY keyboard layout
(ergoemacs-theme-option-off '(apps apps-apps apps-punctuation apps-swap))
(ergoemacs-mode 1)

(setq make-backup-files         nil) ; Don't want any backup files
(setq auto-save-list-file-name  nil) ; Don't want any .saves files
(setq auto-save-default         nil) ; Don't want any auto saving

(setq search-highlight t) ; Highlight search object
(setq query-replace-highlight    t) ; Highlight query object
(setq mouse-sel-retain-highlight t) ; Keep mouse high-lightening
(global-linum-mode t)

(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line

(require 'ido)
(setq emacs-persistence-directory (concat user-emacs-directory ".persistence/"))
(unless (file-exists-p emacs-persistence-directory)
    (make-directory emacs-persistence-directory t))
(setq ido-save-directory-list-file (concat emacs-persistence-directory "ido-last"))
(ido-mode t)

 (defun tidy-buffer ()
  "Run Tidy HTML parser on current buffer."
  (interactive)
  (if (get-buffer "tidy-errs") (kill-buffer "tidy-errs"))
  (shell-command-on-region (point-min) (point-max)
    "tidy -xml -f /tmp/tidy-errs -q -i -wrap 72 -c" t)
  (find-file-other-window "/tmp/tidy-errs")
  (other-window 1)
  (delete-file "/tmp/tidy-errs")
  (message "buffer tidy'ed")
 )

(global-set-key (kbd "M-b") 'ido-switch-buffer)
(global-set-key (kbd "M-1") 'split-window-horizontally)
(global-set-key (kbd "<\S-tab>") 'other-window)
(global-set-key [C-tab] 'other-window)
(global-set-key (kbd "C-t") 'tidy-buffer)
(global-set-key (kbd "M-ESC") 'kill-buffer)
(global-set-key (kbd "M-w") 'ergoemacs-close-current-buffer)
(global-set-key (kbd "C-SPC") 'set-mark-command)
(define-key global-map [?\s-x] ctl-x-map)
(define-key global-map [?\s-g] 'goto-line)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(delete-selection-mode t)
 '(initial-scratch-message #(";; This buffer is for notes you don't want to save, and for Lisp evaluation.
;; If you want to create a file, visit that file with ⇧Shift+Ctrl+O,
;; then enter the text in that file's own buffer." 131 137 (face ergoemacs-pretty-key) 138 142 (face ergoemacs-pretty-key) 143 144 (face ergoemacs-pretty-key)))
 '(org-CUA-compatible t)
 '(org-special-ctrl-a/e t)
 '(org-support-shift-select t)
 '(recentf-menu-before "Close")
 '(recentf-mode t)
 '(scroll-error-top-bottom t)
 '(scroll-preserve-screen-position t)
 '(set-mark-command-repeat-pop t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
