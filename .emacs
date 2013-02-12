;; load path
(add-to-list 'load-path "/usr/share/emacs")
(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/init")
(add-to-list 'load-path "~/.emacs.d/w3m")
(add-to-list 'load-path "~/.emacs.d/jshint-mode")

;; ELPA
;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))
(dolist (sources '(("melpa" . "http://melpa.milkbox.net/packages/")
                  ("marmalade" . "http://marmalade-repo.org/packages/")
                  ("elpa" . "http://tromey.com/elpa/")))
  (add-to-list 'package-archives sources t))

;; custom set variables, NEVER EDIT MANUALLY.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#2e3436" "#a40000" "#4e9a06" "#c4a000" "#204a87" "#5c3566" "#729fcf" "#eeeeec"])
 '(auto-save-list-file-prefix "/tmp/.saves-")
 '(background-color "#fdf6e3")
 '(background-mode light)
 '(bookmark-save-flag 1)
 '(custom-safe-themes (quote ("70ef61cc7736345eb1d2d449a9251e683625ba977f53a4d7cdbd4b9e81425b5e" "d6a00ef5e53adf9b6fe417d2b4404895f26210c52bb8716971be106550cea257" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" "1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" default)))
 '(hl-paren-background-colors (quote ("#3f3f3f")))
 '(hl-paren-colors (quote ("#cccccc" "#cccccc")))
 '(ioccur-buffer-completion-use-ido t)
 '(js2-auto-indent-p t)
 '(js2-mirror-mode nil)
 '(sentence-end-double-space nil)
 '(warning-minimum-level :error))

;; custom set faces, NEVER EDIT MANUALLY.
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cursor ((t (:background "#888"))))
 '(flymake-errline ((t (:background "#333"))))
 '(flymake-warnline ((t (:background "#272727"))))
 '(font-lock-comment-face ((t (:foreground "#7f9f7f" :slant italic :height 0.9 :family "DejaVu Sans Mono"))))
 '(font-lock-constant-face ((t (:weight bold))))
 '(font-lock-keyword-face ((t (:foreground "#cf6a4c" :slant italic :weight normal :family "Consolas"))))
 '(font-lock-type-face ((t (:foreground "#c5af75" :weight bold))))
 '(region ((t (:background "#2a210d"))))
 '(helm-selection ((t (:background "gray18"))) t)
 '(isearch ((t (:background "#222"))))
 '(italic ((t (:slant italic :height 0.9 :family "DejaVu Sans Mono"))))
 '(magit-diff-add ((t (:foreground "green"))) t)
 '(magit-diff-del ((t (:foreground "OrangeRed"))) t)
 '(magit-item-highlight ((t (:inherit (quote zenburn-blue) :background "#171717"))) t)
 '(markdown-italic-face ((t (:inherit font-lock-variable-name-face :slant italic :height 0.9 :family "DejaVu Sans Mono"))))
 '(markdown-link-face ((t (:inherit font-lock-keyword-face :slant normal))))
 '(mode-line-buffer-id ((t (:weight bold))))
 '(quack-pltish-comment-face ((t (:foreground "cyan1"))))
 '(quack-pltish-defn-face ((t (:foreground "SlateBlue" :weight bold))))
 '(quack-threesemi-semi-face ((((class color) (background dark)) (:background "grey30" :foreground "cyan2"))))
 '(quack-threesemi-text-face ((t (:background "grey30" :foreground "white"))))
 '(semantic-decoration-on-unparsed-includes ((t (:background "#222"))))
 '(semantic-decoration-on-unknown-includes ((t (:background "#220"))))
 '(whitespace-line ((t (:background "gray30"))))
 '(whitespace-space-after-tab ((t (:background "gray30" :foreground "gray30"))))
 '(whitespace-space-before-tab ((t (:background "gray30" :foreground "gray30"))))
 '(whitespace-trailing ((t (:background "gray40" :foreground "gray40" :weight bold))))
 '(yas/field-highlight-face ((t (:background "grey10")))))

(put 'downcase-region 'disabled nil)
(put 'autopair-newline 'disabled nil)

;; load init files
(require 'interface-and-environment)
(require 'utils)
(require 'plugins)
(require 'major-modes)
(require 'keybindings)
(require 'experimental)
(require 'server-shutdown-functions)
