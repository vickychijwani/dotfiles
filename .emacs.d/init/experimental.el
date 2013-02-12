;; This file has new and experimental stuff, stuff I'm just trying out and may
;; not make it to my final config. Also, stuff that I'm going to discard.


;; whitespace-mode
;; highlight long lines and tabs
;; free of trailing whitespace and to use 80-column width, standard indentation
(setq whitespace-style '(trailing face lines-tail space-before-tab
                                  indentation space-after-tab)
      whitespace-line-column 80)
(whitespace-mode t)


;; makes you learn the proper Emacs movement keys
;; (require 'no-easy-keys)
;; (no-easy-keys 1)


;; make hs-minor-mode work with Ruby code
(defun hs-ruby-setup ()
  (add-to-list 'hs-special-modes-alist
               '(ruby-mode
                 "\\(def\\|do\\)"
                 "end"
                 "#"
                 (lambda (arg) (ruby-end-of-block))
                 nil))
  (hs-minor-mode t))
(add-hook 'ruby-mode-hook 'hs-ruby-setup)


;; visual markers in the fringe for code folding
(require 'fold-dwim)
(autoload 'hideshowvis-enable "hideshowvis" "Highlight foldable regions")
(autoload 'hideshowvis-minor-mode "hideshowvis"
  "Will indicate regions foldable with hideshow in the fringe." 'interactive)
(hideshowvis-symbols)
(set-face-attribute 'hs-face nil :foreground "#88b090" :background "#2e3330"
                    :box '(:color "#88b090" :line-width 1))
(dolist (hook (list 'lisp-mode-hook
                    'emacs-lisp-mode-hook
                    'c-mode-common-hook
                    'java-mode-hook
                    'js-mode-hook
                    'emacs-lisp-mode-hook
                    'clojure-mode-hook
                    'css-mode-hook
                    'ruby-mode-hook))
  (add-hook hook 'hideshowvis-enable))



;; ruby-block.el: highlighting matching block
(require 'ruby-block)
(ruby-block-mode t)
(setq ruby-block-highlight-toggle 'overlay
      ruby-block-delay 0
      ruby-block-highlight-face 'zenburn-background-1)


;; golden-ratio.el: automatically enlarges the focused window in a split frame,
;; by a factor equal to "The Golden Ratio"
;; (require 'golden-ratio)


;; this is a workaround for a bug in emacs' http fetching, see
;; http://lists.gnu.org/archive/html/bug-gnu-emacs/2011-12/msg00196.html
(setq url-http-attempt-keepalives nil)



;; highlight-changes-mode
;; (global-highlight-changes-mode t)
;; (setq highlight-changes-visibility-initial-state nil) ;; initially hide
;; (global-set-key (kbd "<f6>") 'highlight-changes-visible-mode) ;; changes
;; (global-set-key (kbd "<f5>") 'highlight-changes-next-change)
;; (global-set-key (kbd "S-<f5>") 'highlight-changes-previous-change)

;; (add-hook 'after-save-hook
;;           (lambda ()
;;             (highlight-changes-remove-highlight (point-min) (point-max))))



;;;; softly highlight trailing whitespace and lines longer than 80 characters

;; (add-hook 'font-lock-mode-hook
;;           '(lambda ()
;;              (setq font-lock-keywords
;;                    (append font-lock-keywords
;;                            '(("\t+" (0 'my-tab-face t))
;;                              ("^.\\{81,\\}$" (0 'my-long-line-face t))
;;                              ("[ \t]+$" (0 'my-trailing-space-face t)))))))


;; PARTIAL CODE I'M TINKERING WITH

;; (defface long-line-face
;;   '((t (:background "#003336")))
;;   "Face used to highlight long lines.")

;; (defvar long-line-overlay
;;   ;; dummy initialization
;;   (make-overlay (line-beginning-position) (line-end-position))
;;   "Overlay for long lines.")

;; (overlay-put long-line-overlay 'face 'long-line-face)



(provide 'experimental)
