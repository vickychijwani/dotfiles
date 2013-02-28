;; This file has all major *EDITING* modes and their settings (except keybindings, which are in keybindings.el)

;; set categories of strings to be handled by pretty symbols mode
(require 'pretty-symbols)
(setq pretty-symbol-categories '(lambda))

;; octave-mode for matlab and friends
(add-to-list 'auto-mode-alist '("\\.m$" . octave-mode))

;; coffee-mode
(setq coffee-tab-width 2)

;; nxhtml-mode
(load "~/.emacs.d/nxhtml-beta/autostart.el")
(setq mumamo-background-colors nil)

;; clojure-mode
(autoload 'clojure-mode "clojure-mode" "" t)

;; js mode
(require 'flymake-jshint) ;; jshint errors in flymake mode
(setq js-indent-level 2)
(add-hook 'js-mode-hook
          '(lambda ()
             (enable-paredit-mode)
             (flymake-mode-on)
             (pretty-symbols-mode)))

;; org-mode
(setq-default org-hide-leading-stars t
              org-agenda-files '("~/.deft/todo.org"))

;; c-mode
(semantic-mode t)
(global-semanticdb-minor-mode +1)
(global-semantic-idle-scheduler-mode +1)
(global-semantic-idle-summary-mode +1)
(global-semantic-stickyfunc-mode +1)
(global-semantic-decoration-mode +1)
(global-semantic-idle-local-symbol-highlight-mode +1)
(setq c-basic-offset 4
      c-block-comment-prefix "* ")
(add-hook 'c-mode-common-hook
          (lambda ()
            (enable-paredit-mode)
            (flymake-mode-on)
            (local-set-key (kbd "C-M-`") 'semantic-ia-fast-jump)
            (local-set-key (kbd "C-M-2") 'semantic-analyze-proto-impl-toggle)
            (local-set-key (kbd "<f1>") 'man-page-for-symbol-at-point)
            (local-set-key (kbd "<f2>") 'semantic-ia-show-doc)
            (local-set-key (kbd "M-/") 'semantic-ia-complete-symbol) ;; replacement for dabbrev-expand
            (pretty-symbols-mode)
            ;; highlight FIXME, TODO, BUG, etc. in comments
            (font-lock-add-keywords
             nil
             '(("\\<\\(FIXME\\|TODO\\|BUG\\|FIX\\|NOTE\\):" 1 font-lock-warning-face t)))))

;; haml-mode and sgml-mode (on which html-mode is based)
(autoload 'haml-mode "haml-mode" "" t)
(add-to-list 'auto-mode-alist '("\\.haml$" . haml-mode))
(add-hook 'haml-mode-hook
          '(lambda ()
             (zencoding-mode)
             (enable-paredit-mode)
             ;; get rid of annoying keybindings in haml-mode
             (defalias 'haml-electric-backspace 'paredit-backward-delete)
             (defalias 'haml-output-region 'comment-or-uncomment-region-or-line)))
(add-hook 'sgml-mode-hook 'zencoding-mode)

;; ruby-mode
(font-lock-add-keywords 'ruby-mode
                        '(("lambda" . font-lock-keyword-face)
                          ("->" . font-lock-keyword-face)
                          ("||" . font-lock-keyword-face)
                          ("&&" . font-lock-keyword-face)))
(add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Guardfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.thor\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Thorfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Vagrantfile\\'" . ruby-mode))
(add-hook 'ruby-mode-hook
          (lambda ()
            (enable-paredit-mode)
            (ruby-tools-mode +1)
            (pretty-symbols-mode)))

;; css-mode
(add-hook 'css-mode-hook 'hexcolor-add-to-font-lock)

;; less-css-mode
(autoload 'less-css-mode "less-css-mode.el" "" t)
(add-hook 'less-css-mode-hook 'hexcolor-add-to-font-lock)

;; lua-mode
(autoload 'lua-mode "lua-mode.el" "" t)

;; python-mode (Emacs 23 ships with python.el, but this is better)
(autoload 'python-mode "python-mode" "" t)
(add-to-list 'auto-mode-alist '("\\.py$" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))
(add-hook 'python-mode-hook 'pretty-symbols-mode)

;; markdown-mode
(add-to-list 'auto-mode-alist '("\\.txt$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode))

;; jekyll
(require 'jekyll)
(require 'jekyll-mumamo)
(jekyll-init-keybindings)
(add-to-list 'jekyll-modes-list '("c" 'c-mode))
(add-to-list 'jekyll-modes-list '("c++" 'c++-mode))
(add-to-list 'jekyll-modes-list '("python" 'python-mode))
(add-to-list 'jekyll-modes-list '("ruby" 'ruby-mode))
(add-to-list 'jekyll-modes-list '("js" 'js-mode))
(add-to-list 'jekyll-modes-list '("console" 'shell-script-mode))
(add-to-list 'jekyll-modes-list '("bash" 'shell-script-mode))
(add-to-list 'jekyll-modes-list '("scheme" 'scheme-mode))
(add-to-list 'jekyll-modes-list '("cl" 'common-lisp-mode))
(add-to-list 'auto-mode-alist '("_\\(posts\\|drafts\\).*\\.md$" . jekyll-markdown-mumamo-mode))
(setq jekyll-directory "/home/vicky/Documents/blog/"
      jekyll-post-ext ".md"
      jekyll-post-template "---\nlayout: post\ntitle: %s\ndate: \ncomments: true\ncategories: \n---\n\n")

;; yaml-mode
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;; lisp modes
(defun enable-lisp-utils ()
  (enable-paredit-mode)
  (hexcolor-add-to-font-lock)
  (pretty-symbols-mode))
(dolist (hooks (list 'scheme-mode-hook
                     'lisp-mode-hook
                     'emacs-lisp-mode-hook
                     'inferior-lisp-mode-hook
                     'inferior-scheme-mode-hook
                     'clojure-mode-hook))
        (add-hook hooks 'enable-lisp-utils))

;; scheme-mode
;; default scheme implementation
(setq scheme-default-implementation 'mit-scheme)
;; quack customizations
(setq quack-default-program "mit-scheme"
      quack-fontify-style 'plt
      quack-pretty-lambda-p t
      quack-remap-find-file-bindings-p nil
      quack-run-scheme-always-prompts-p nil)
;; live scheme documentation with scheme-complete + eldoc
(defun enable-scheme-utils ()
  (make-local-variable 'eldoc-documentation-function)
  (setq eldoc-documentation-function 'scheme-get-current-symbol-info)
  (eldoc-mode))
(dolist (hooks (list 'scheme-mode-hook 'inferior-scheme-mode-hook))
        (add-hook hooks 'enable-scheme-utils))

(provide 'major-modes)
