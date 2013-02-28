;; This file has all interface / editing environment customizations
;; and modifications to Emacs' core functions

;; color theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'sunburst t)

;; When I was a child, I spake as a child,
;; I understood as a child, I thought as a child:
;; but when I became a man, I put away childish things.
;;   -- 1 Corinthians, 13:11
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)

;; display format for line numbers on the left side
(setq linum-format " %d ")

;; use the X windows system clipboard
(setq x-select-enable-clipboard 1)

;; set default font and font size. Only ONE of the following should be enabled!
(set-face-attribute 'default nil :family "Consolas" :height 125)
;; (set-face-attribute 'default nil :family "Monaco" :height 110)
;; (set-face-attribute 'default nil :family "Inconsolata" :height 130)
;; (set-face-attribute 'default nil :family "Andale Mono" :height 125)
;; (set-face-attribute 'default nil :family "DejaVu Sans Mono" :height 125)

;; default line spacing, original value was nil
(setq-default line-spacing 1)

;; default browser
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "chromium")
;; (setq browse-url-browser-function 'w3m-browse-url)
;; (autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)

;; prevent nag message "Buffer 'buffername' still has clients; kill it?"
;; when using C-x C-k to kill server buffers
(remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function)

;; delete selections with backspace and overwrite them by starting to type
(delete-selection-mode t)

;; NEVER use tabs
(setq-default indent-tabs-mode nil)

;; show trailing whitespace
(setq-default show-trailing-whitespace t)

;; delete trailing whitespace and blank lines at the end before saving files
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'before-save-hook
          '(lambda ()
             (interactive)
             (save-excursion
              (save-restriction
               (widen)
               (goto-char (point-max))
               (delete-blank-lines)))))

;; show column number in mode line
(column-number-mode 1)

;; disable the creation of backup files (so that the inotify watcher can detect
;; modifications and run commands on files automatically)
(setq make-backup-files nil)

;; for handling open files with same names
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; Interactively Do Things - UX improvement for the minibuffer
(ido-mode 1)
(setq ido-everywhere t
      ido-enable-flex-matching t
      ido-ignore-buffers '("\\` " "*Messages*" "*Completions*" "*Buffer List*"
                           "*scratch*" "*Help*" "*Backtrace*"))

;; auto-update imenu index
(setq imenu-auto-rescan t)

;; fill column
(setq-default fill-column 80)

;; set LC_ALL=C to disable stupid "smart quotes" in Flymake errors
(setenv "LC_ALL" "C")

;; capitalized-words-mode - smart navigation for CamelCase words
(defun enable-capitalized-words-mode ()
  (capitalized-words-mode t))
(dolist (hooks (list 'java-mode-hook
                     'python-mode-hook
                     'c-mode-common-hook
                     'js-mode-hook
                     'clojure-mode-hook
                     'nrepl-mode-hook))
        (add-hook hooks 'enable-capitalized-words-mode))

;; compact completion suggestions in the minibuffer
(icomplete-mode 1)

;; track recently-opened files
(recentf-mode 1)
(setq recentf-max-menu-items 100)

;; automatically insert newline at the end of every file
(setq require-final-newline 'ask)

;; make point end up at the beginning of the match when pressing RET during isearch
(add-hook 'isearch-mode-end-hook 'my-goto-match-beginning)
(defun my-goto-match-beginning ()
  (when (and isearch-forward isearch-other-end (not isearch-mode-end-hook-quit))
    (goto-char isearch-other-end)))

;; always follow symlinks to files under version control without asking
(setq vc-follow-symlinks t)

(provide 'interface-and-environment)
