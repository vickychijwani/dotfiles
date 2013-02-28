;; this file has all customized key-bindings (global and mode-specific)

;; keybindings for built-in functions
(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "<f7>") 'toggle-truncate-lines)
(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)
(global-set-key (kbd "C-w") 'backward-kill-word)
(global-set-key (kbd "C-S-k") 'kill-whole-line)
(global-set-key (kbd "C-S-x C-S-r") 'ido-recentf-open-files)
(global-set-key (kbd "C-S-j") (lambda () (interactive) (join-line -1)))
(global-set-key (kbd "C-l") 'ido-switch-buffer)
(global-set-key (kbd "C-|") 'align-regexp)

(global-set-key (kbd "<C-tab>") 'next-multiframe-window)
(global-set-key (kbd "<C-S-iso-lefttab>") 'previous-multiframe-window)

(global-set-key (kbd "<f5>") 'flymake-goto-prev-error)
(global-set-key (kbd "<f6>") 'flymake-goto-next-error)


;; keybindings for custom functions (which are in utils.el)
;;;; text editing / navigation utilies
(global-set-key (kbd "M-Q") 'unfill-paragraph)
(global-set-key (kbd "C-c C-e") 'eval-and-replace)
(global-set-key (kbd "C-M-s") 'instant-search-using-helm)
(global-set-key (kbd "C-M-S-s") 'helm-resume)
(global-set-key (kbd "C-M-g") 'instant-rgrep-using-helm)
(global-set-key (kbd "RET") 'newline-and-indent-in-parens)
(global-set-key (kbd "C-c C-d") 'duplicate-current-line-or-region)
(global-set-key (kbd "C-c C-r") 'comment-or-uncomment-region-or-line)

;;;; rename and delete get dedicated keybindings
(global-set-key (kbd "C-x C-d") 'delete-current-file-and-buffer)
(global-set-key (kbd "C-x C-r") 'rename-current-file-and-buffer)

;;;; home / C-a toggle between first non-blank character of line and beginning of line
(global-set-key [home] 'smart-beginning-of-line)
(global-set-key (kbd "C-a") 'smart-beginning-of-line)

;;;; F11 for fullscreen
(global-set-key (kbd "<f11>") 'full-screen-toggle)

;;;; C-= / C-- for zooming in and out
(global-set-key (kbd "C-+") '(lambda nil (interactive) (zoom 1)))
(global-set-key [C-kp-add] '(lambda nil (interactive) (zoom 1)))
(global-set-key (kbd "C--") '(lambda nil (interactive) (zoom -1)))
(global-set-key [C-kp-subtract] '(lambda nil (interactive) (zoom -1)))

;;;; window resizing
(global-set-key (kbd "M-S-<left>") 'move-border-left)
(global-set-key (kbd "M-S-<right>") 'move-border-right)
(global-set-key (kbd "M-S-<up>") 'move-border-up)
(global-set-key (kbd "M-S-<down>") 'move-border-down)


;; keybindings for plugins
;;;; multiple-cursors
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C-c m n") 'mc/mark-next-like-this)
(global-set-key (kbd "C-c m p") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c m a") 'mc/mark-all-like-this)

;;;; code folding
(global-set-key (kbd "<f3>") 'fold-dwim-toggle)
(global-set-key (kbd "<M-f3>") 'fold-dwim-hide-all)
(global-set-key (kbd "<S-M-f3>") 'fold-dwim-show-all)

;; ido enhancement for imenu-mode (code navigation by function name)
(global-set-key (kbd "M-`") 'idomenu)

;;;; expand region
(global-set-key (kbd "C-=") 'er/expand-region)

;;;; ace jump mode
(global-set-key (kbd "M-e") 'ace-jump-mode)
(global-set-key (kbd "M-E") 'ace-jump-char-mode)

;;;; dired / wdired mode
(add-hook 'dired-mode-hook
          '(lambda ()
             (define-key dired-mode-map (kbd "C-c C-q") 'dired-toggle-read-only)
             (define-key dired-mode-map (kbd "C-c C-k") 'wdired-abort-changes)))

;;;; move stuff around with M-up / M-down
(move-text-default-bindings)

;;;; Better undo (like normal text editors, plus you can visualize the undo tree)
(global-undo-tree-mode 1)

;;;; paredit
(eval-after-load "paredit"
  '(progn (define-key paredit-mode-map (kbd "{") 'paredit-open-curly)
          (define-key paredit-mode-map (kbd "}") 'paredit-close-curly)
          (define-key paredit-mode-map (kbd "DEL") 'paredit-backward-delete)
          (define-key paredit-mode-map (kbd "C-w") 'paredit-backward-kill-word)
          (define-key paredit-mode-map (kbd "S-<delete>") 'paredit-kill-region)
          (define-key paredit-mode-map (kbd "M-)") 'paredit-wrap-round-from-behind)
          (define-key paredit-mode-map (kbd "M-<up>") nil)
          (define-key paredit-mode-map (kbd "M-<down>") nil)))

;;;; auto-complete-mode
(eval-after-load "auto-complete"
  '(progn (define-key ac-mode-map (kbd "TAB") 'auto-complete)))

;;;; magit
(global-set-key (kbd "C-x g s") 'magit-status)
(eval-after-load "magit"
  '(progn (define-key magit-status-mode-map (kbd "q") 'magit-quit-session)))

;;;; smex
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c M-x") 'execute-extended-command)

;;;; my-desktop
(global-set-key (kbd "C-x x r") 'my-desktop-read)
(global-set-key (kbd "C-x x s") 'my-desktop-save)
(global-set-key (kbd "C-x x c") 'my-desktop-change)
(global-set-key (kbd "C-x x d") 'my-desktop-save-and-clear)

;;;; escreen
(global-set-key (kbd "C-\\ l") 'escreen-echo-active-screen-numbers-with-emphasis)
(global-set-key (kbd "<f9>") 'escreen-create-screen-dim)
(global-set-key (kbd "S-<f9>") 'escreen-kill-screen-dim)
(global-set-key (kbd "M-1") 'escreen-goto-screen-0)
(global-set-key (kbd "M-2") 'escreen-goto-screen-1)
(global-set-key (kbd "M-3") 'escreen-goto-screen-2)
(global-set-key (kbd "M-4") 'escreen-goto-screen-3)
(global-set-key (kbd "M-5") 'escreen-goto-screen-4)
(global-set-key (kbd "M-6") 'escreen-goto-screen-5)
(global-set-key (kbd "M-7") 'escreen-goto-screen-6)
(global-set-key (kbd "M-8") 'escreen-goto-screen-7)
(global-set-key (kbd "M-9") 'escreen-goto-screen-8)
(global-set-key (kbd "M-0") 'escreen-goto-screen-9)



;; major mode-specific keybindings
;;;; ruby-mode
(add-hook 'ruby-mode-hook
          '(lambda ()
             (local-set-key (kbd "<f1>") 'yari)))

;;;; scheme-mode and inferior-scheme-mode
(define-key scheme-mode-map "\t" 'scheme-complete-or-indent)
(define-key inferior-scheme-mode-map "\t" 'scheme-complete-or-indent)

;;;; python-mode
(add-hook 'python-mode-hook
          '(lambda ()
             (local-set-key (kbd "C-c h") 'pylookup-lookup)
             (local-unset-key (kbd "C-c C-k"))))

;;;; w3m-mode
(add-hook 'w3m-mode-hook
          '(lambda ()
             (define-key w3m-mode-map (kbd "<C-tab>") 'w3m-next-buffer)
             (define-key w3m-mode-map (kbd "<C-S-iso-lefttab>") 'w3m-previous-buffer)
             (define-key w3m-mode-map (kbd "C-x k") 'w3m-delete-buffer)))

;;;; markdown-mode
(add-hook 'markdown-mode-hook
          '(lambda ()
             (local-unset-key (kbd "<tab>"))
             (define-key markdown-mode-map (kbd "C-c d") 'date)))


(provide 'keybindings)
