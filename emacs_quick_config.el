;; Use `M-x load-file RET /path/to/this/file` in order to quickly get a decent
;; but basic Emacs config up and running

;; death to annoying UI elements!
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

;; line numbers
(setq linum-format " %d ")

;; use the X windows system clipboard
(setq x-select-enable-clipboard 1)

;; don't show GNU Emacs welcome screen
(setq inhibit-startup-message t)

;; make highlighting work sanely (only needed for Emacs v22 or older)
(transient-mark-mode t)

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

;; Interactively Do Things - awesome UX improvement for the minibuffer
(ido-mode 1)
(setq ido-everywhere t
      ido-enable-flex-matching t
      ido-ignore-buffers '("\\` " "*Messages*" "*Completions*" "*Buffer List*"
                           "*scratch*" "*Help*" "*Backtrace*"))

;; for handling open files with same names
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward
      uniquify-separator ":")

;; tramp mode
(require 'tramp)
(setq tramp-default-method "scp")

;; fill column
(setq-default fill-column 80)

;; dabbrev config
(setq dabbrev-case-fold-search 'nil
      dabbrev-ignore-buffer-names '("*Messages*" "*Buffer List*" "*scratch*" "*GNU Emacs*"))

;; subword-mode / capitalized-words-mode - smart navigation for CamelCase words
(global-subword-mode t)
(defun enable-capitalized-words-mode ()
  (capitalized-words-mode t))
(dolist (hooks (list 'java-mode-hook
                     'python-mode-hook
                     'c-mode-common-hook
                     'js-mode-hook))
  (add-hook hooks 'enable-capitalized-words-mode))


;;; keybindings
;; general
(global-set-key (kbd "M-g") 'goto-line)
(global-set-key "\C-c\C-r" 'comment-or-uncomment-region-or-line)
(global-set-key (kbd "<f7>") 'toggle-truncate-lines)
(global-set-key "\C-x\C-b" 'ido-switch-buffer)
(global-set-key "\C-w" 'backward-kill-word) ;; readline-style

(global-set-key (kbd "<C-tab>") 'next-multiframe-window)
(global-set-key (kbd "<C-S-iso-lefttab>") 'previous-multiframe-window)

(global-set-key "\C-s" 'isearch-forward-regexp)
(global-set-key "\C-r" 'isearch-backward-regexp)
(global-set-key "\C-\M-s" 'isearch-forward)
(global-set-key "\C-\M-r" 'isearch-backward)

;; window resizing
(global-set-key (kbd "M-S-<left>") 'move-border-left)
(global-set-key (kbd "M-S-<right>") 'move-border-right)
(global-set-key (kbd "M-S-<up>") 'move-border-up)
(global-set-key (kbd "M-S-<down>") 'move-border-down)

;; home / C-a toggle between first non-blank character of line and beginning of line
(global-set-key [home] 'smart-beginning-of-line)
(global-set-key "\C-a" 'smart-beginning-of-line)

;; F11 for fullscreen
(global-set-key (kbd "<f11>") 'full-screen-toggle)

;; C-= / C-- for zooming in and out
(global-set-key (kbd "C-=") '(lambda nil (interactive) (zoom 1)))
(global-set-key [C-kp-add] '(lambda nil (interactive) (zoom 1)))
(global-set-key (kbd "C--") '(lambda nil (interactive) (zoom -1)))
(global-set-key [C-kp-subtract] '(lambda nil (interactive) (zoom -1)))


;;; major mode customizations
;; c-mode
(setq c-basic-offset 4
      c-block-comment-prefix "* ")


;;; various utility functions
;; primitive auto-complete on TAB
(defun smart-tab ()
  "This smart tab is minibuffer compliant: it acts as usual in
    the minibuffer. Else, if mark is active, indents region. Else if
    point is at the end of a symbol, expands it. Else indents the
    current line."
  (interactive)
  (if (minibufferp)
      (unless (minibuffer-complete)
        (dabbrev-expand nil))
      (if mark-active
          (indent-region (region-beginning)
                         (region-end))
          (if (looking-at "\\_>")
              (dabbrev-expand nil)
              (indent-for-tab-command)))))

(global-set-key (kbd "TAB") 'smart-tab)

;; move a line / region up and down (M-up / M-down), taken from move-text.el
(defun move-text-internal (arg)
  (cond
   ((and mark-active transient-mark-mode)
    (if (> (point) (mark))
        (exchange-point-and-mark))
    (let ((column (current-column))
          (text (delete-and-extract-region (point) (mark))))
      (forward-line arg)
      (move-to-column column t)
      (set-mark (point))
      (insert text)
      (exchange-point-and-mark)
      (setq deactivate-mark nil)))
   (t
    (let ((column (current-column)))
      (beginning-of-line)
      (when (or (> arg 0) (not (bobp)))
        (forward-line)
        (when (or (< arg 0) (not (eobp)))
          (transpose-lines arg))
        (forward-line -1))
      (move-to-column column t)))))

(defun move-text-down (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines down."
  (interactive "*p")
  (move-text-internal arg))

(defun move-text-up (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines up."
  (interactive "*p")
  (move-text-internal (- arg)))

(defun move-text-default-bindings ()
  "Bind `move-text-up' and `move-text-down' to M-up and M-down."
  (global-set-key [M-up] 'move-text-up)
  (global-set-key [M-down] 'move-text-down))

(move-text-default-bindings)


;; comment or uncomment region or line
(defun comment-or-uncomment-region-or-line ()
  "Like comment-or-uncomment-region, but if there's no mark \(that means no
region\) apply comment-or-uncomment to the current line"
  (interactive)
  (if (not mark-active)
      (comment-or-uncomment-region
       (line-beginning-position) (line-end-position))
    (if (< (point) (mark))
        (comment-or-uncomment-region (point) (mark))
      (comment-or-uncomment-region (mark) (point)))))

;; "smart" home, i.e., home toggles b/w 1st non-blank character and 1st column
(defun smart-beginning-of-line ()
  "Move point to first non-whitespace character or beginning-of-line."
  (interactive "^") ; Use (interactive "^") in Emacs 23 to make shift-select work
  (let ((oldpos (point)))
    (back-to-indentation)
    (and (= oldpos (point))
         (beginning-of-line))))

;; f11 for fullscreen
(defun full-screen-toggle ()
  "toggle full-screen mode"
  (interactive)
  (shell-command "wmctrl -r :ACTIVE: -btoggle,fullscreen"))

;; zoom in / out using C-= / C--
(defun zoom (n)
  "with positive N, increase the font size, otherwise decrease it"
  (set-face-attribute 'default (selected-frame) :height
		      (+ (face-attribute 'default :height) (* (if (> n 0) 1 -1) 10))))

;; intuitive window resizing
(defun xor (b1 b2)
  (or (and b1 b2)
      (and (not b1) (not b2))))

(defun move-border-left-or-right (arg dir)
  "General function covering move-border-left and move-border-right. If DIR is
     t, then move left, otherwise move right."
  (interactive)
  (if (null arg) (setq arg 3))
  (let ((left-edge (nth 0 (window-edges))))
    (if (xor (= left-edge 0) dir)
        (shrink-window arg t)
        (enlarge-window arg t))))

(defun move-border-up-or-down (arg dir)
  "General function covering move-border-up and move-border-down. If DIR is
     t, then move up, otherwise move down."
  (interactive)
  (if (null arg) (setq arg 3))
  (let ((top-edge (nth 1 (window-edges))))
    (if (xor (= top-edge 0) dir)
        (shrink-window arg nil)
        (enlarge-window arg nil))))

(defun move-border-left (arg)
  (interactive "P")
  (move-border-left-or-right arg t))

(defun move-border-right (arg)
  (interactive "P")
  (move-border-left-or-right arg nil))

(defun move-border-up (arg)
  (interactive "P")
  (move-border-up-or-down arg t))

(defun move-border-down (arg)
  (interactive "P")
  (move-border-up-or-down arg nil))
