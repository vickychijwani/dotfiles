;; This file contains all EXTERNAL plugins / applications. Configuration for
;; BUILT-IN plugins should go into interface-and-environment.el

;; minor plugins

;;;; clean and powerful modeline
(require 'powerline)
(set-face-attribute 'mode-line nil :foreground "#f0dfaf" :background "#1e2320" :box nil)
(set-face-attribute 'mode-line-inactive nil :foreground "#88b090" :background "#2e3330" :box nil)

;;;; compact / hidden minor mode names in the modeline
(when (require 'diminish nil 'noerror)
  (eval-after-load "paredit"               '(diminish 'paredit-mode               " (Par)"))
  (eval-after-load "yasnippet"             '(diminish 'yas/minor-mode             " YAS"))
  (eval-after-load "highlight-parentheses" '(diminish 'highlight-parentheses-mode ""))
  (eval-after-load "eldoc"                 '(diminish 'eldoc-mode                 ""))
  (eval-after-load "autopair"              '(diminish 'autopair-mode              " (AP)"))
  (eval-after-load "auto-complete"         '(diminish 'auto-complete-mode         " AC"))
  (eval-after-load "abbrev"                '(diminish 'abbrev-mode                ""))
  (eval-after-load "ruby-block"            '(diminish 'ruby-block-mode            ""))
  (eval-after-load "cap-words"             '(diminish 'capitalized-words-mode     ""))
  (eval-after-load "undo-tree"             '(diminish 'undo-tree-mode             ""))
  (eval-after-load "whitespace"            '(diminish 'whitespace-mode            ""))
  (eval-after-load "hideshow"              '(diminish 'hs-minor-mode              ""))
  (eval-after-load "ruby-tools"            '(diminish 'ruby-tools-mode            ""))
  (eval-after-load "pretty-symbols"        '(diminish 'pretty-symbols-mode        ""))
  (eval-after-load "ruby-electric"         '(diminish 'ruby-electric-mode         ""))
  )

;;;; ido-enabled jump-to-definition (better than imenu, works in many modes)
(autoload 'idomenu "idomenu" nil t)

;;;; ido everywhere, seriously
(ido-ubiquitous-mode t)

;;;; grant fuzzy-searching superpowers to isearch
(require 'fuzzy)
(turn-on-fuzzy-isearch)

;;;; tramp mode
(require 'tramp)
(setq tramp-default-method "scp")
;; (set-default 'tramp-default-proxies-alist (quote ((".*" "\\`root\\'" "/ssh:%h:"))))

;;;; flymake-mode
(require 'flymake-cursor) ;; show error on current line in minibuffer
(require 'rfringe) ;; show buffer-relative positions of errors in the right fringe
(setq flymake-gui-warnings-enabled nil)

;;;; shell command TAB completion
(eval-after-load "shell-command"
  '(progn
     (shell-command-completion-mode 1)))

;;;; scheme-complete
(autoload 'scheme-smart-complete "scheme-complete" nil t)
(autoload 'scheme-get-current-symbol-info "scheme-complete" nil t)
(autoload 'scheme-smart-indent-function "scheme-complete" nil t)

;;;; eldoc (shows argument lists for functions in the modeline)
(require 'eldoc)
(eldoc-mode 1)

;;;; auto-complete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(setq ac-auto-show-menu t
      ac-expand-on-auto-complete nil
      ac-quick-help-delay 0.2)
(add-to-list 'ac-modes 'haml-mode)
(ac-config-default)
(ac-linum-workaround) ;; fix for annoying bug with AC + linum mode

(require 'auto-complete-clang)
(setq ac-clang-flags
      (mapcar (lambda (item)(concat "-I" item))
              (split-string
               "
 /usr/lib/gcc/i686-pc-linux-gnu/4.7.2/../../../../include/c++/4.7.2
 /usr/lib/gcc/i686-pc-linux-gnu/4.7.2/../../../../include/c++/4.7.2/i686-pc-linux-gnu
 /usr/lib/gcc/i686-pc-linux-gnu/4.7.2/../../../../include/c++/4.7.2/backward
 /usr/lib/gcc/i686-pc-linux-gnu/4.7.2/include
 /usr/local/include
 /usr/lib/gcc/i686-pc-linux-gnu/4.7.2/include-fixed
 /usr/include
"))
      ac-clang-executable "/usr/bin/clang")

(global-auto-complete-mode t)

;;;; my desktop: save editing sessions by name
(require 'my-desktop)

;;;; paredit (pseudo-structural editing of parentheses and quotes)
(autoload 'enable-paredit-mode "paredit" "" t)
(modify-syntax-entry ?\{ "(}")
(modify-syntax-entry ?\} "){")

;;;; smart auto-pairing brakcets, quotes, etc. http://code.google.com/p/autopair/
(require 'autopair)
;; (autopair-global-mode 1) ;; enable autopair in all buffers
;; (setq autopair-autowrap t)
(add-hook 'term-mode-hook
          #'(lambda () (setq autopair-dont-activate t)))

;;;; yasnippet
(require 'yasnippet) ;; not yasnippet-bundle
;; (require 'yas-jit)
(yas/initialize)
;; (setq yas/root-directory "~/.emacs.d/snippets/text-mode/")
(yas/load-directory "~/.emacs.d/snippets")
;; (yas/jit-load)
(yas/global-mode 1)
(setq yas/triggers-in-field t)

;;;; Quack for scheme (syntax-highlighting, pretty lambdas, other good stuff)
(require 'quack)

;;;; Yank and indent replaces yank
(require 'yank-indent)

;;;; pylookup
(autoload 'pylookup-lookup "pylookup")
(autoload 'pylookup-update "pylookup")
(setq pylookup-program "~/.emacs.d/pylookup/pylookup.py")
(setq pylookup-db-file "~/.emacs.d/pylookup/pylookup.db")

;;;; highlight parentheses
(require 'highlight-parentheses)
;; integration with autopair
(add-hook 'highlight-parentheses-mode-hook
          '(lambda ()
             (setq autopair-handle-action-fns
                   (append
		    (if autopair-handle-action-fns
			autopair-handle-action-fns
                        '(autopair-default-handle-action))
		    '((lambda (action pair pos-before)
			(hl-paren-color-update)))))))
;; enable it for all buffers
(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)))
(global-highlight-parentheses-mode t)

;;;; smex
(autoload 'smex "smex.el" "Ido-style M-x" t)
(smex-initialize)

;;;; zen coding
(setq zencoding-indentation 2)



;; major applications

;;;; magit
(autoload 'magit "magit.el" "Git interface for Emacs." t)

;;;; w3m
(autoload 'w3m-session "w3m-session.el" "w3m session" t)
(autoload 'w3m-load "w3m-load" "w3m load" t)
(autoload 'w3m-cookie "w3m-cookie" "w3m cookie" t)
(setq w3m-home-page "http://www.google.com"
      w3m-tab-width 20
      w3m-use-cookies t
      w3m-session-file "/tmp/w3m-session"
      w3m-session-save-always t
      w3m-session-load-always t
      w3m-favicon-use-cache-file t
      w3m-favicon-cache-file ""
      w3m-favicon-size '(16 . 16))
(add-hook 'w3m-mode-hook
          '(lambda ()
             (setq show-trailing-whitespace nil)))

;;;; deft
(autoload 'deft "deft" "" t)
(when (autoload 'deft "deft" "Quick note-taking" t)
  (setq
   deft-extension "txt"
   deft-text-mode 'markdown-mode
   deft-auto-save-interval 30.0
   deft-use-filename-as-title t))

;;;; escreen
(load "escreen")
(escreen-install)

;; display screens in modeline
;; (let ((pos (memq 'mode-line-modes mode-line-format)))
;;   (setcdr pos (cons '(:eval (escreen-get-active-screen-numbers-with-emphasis)) (cdr pos))))

(add-hook 'escreen-goto-screen-hook 'escreen-echo-active-screen-numbers-with-emphasis)

(provide 'plugins)
