;; This file has small custom utility functions and the like

;; evaluate the last sexp and replace it with the result
(defun eval-and-replace ()
  (interactive)
  (let ((value (eval (preceding-sexp))))
    (kill-sexp -1)
    (insert (format "%s" value))))


;; does what it says
(defun man-page-for-symbol-at-point ()
  (interactive)
  (let ((sym (thing-at-point 'symbol)))
    (man sym)))


;; fullscreen magit status
(defadvice magit-status (around magit-fullscreen activate)
  (window-configuration-to-register :magit-fullscreen)
  ad-do-it
  (delete-other-windows))

(defun magit-quit-session ()
  "Restores the previous window configuration and kills the magit buffer"
  (interactive)
  (kill-buffer)
  (jump-to-register :magit-fullscreen))


;; functions for renaming / deleting files
(defun delete-current-file-and-buffer ()
  "Removes file connected to current buffer and kills buffer."
  (interactive)
  (let ((filename (buffer-file-name))
        (buffer (current-buffer))
        (name (buffer-name)))
    (if (not (and filename (file-exists-p filename)))
        (ido-kill-buffer)
      (when (yes-or-no-p "Are you sure you want to remove this file? ")
        (delete-file filename)
        (kill-buffer buffer)
        (message "File '%s' successfully removed" filename)))))

(defun rename-current-file-and-buffer ()
  "Renames current buffer and file it is visiting."
  (interactive)
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
      (let ((new-name (read-file-name "New name: " filename)))
        (if (get-buffer new-name)
            (error "A buffer named '%s' already exists!" new-name)
          (rename-file filename new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil)
          (message "File '%s' successfully renamed to '%s'"
                   name (file-name-nondirectory new-name)))))))


;; instant recursive grep on a directory with helm
(defun instant-rgrep-using-helm ()
  "recursive grep in a directory."
  (interactive)
  (let ((helm-after-initialize-hook #'helm-follow-mode))
    ;; (setq current-prefix-arg '(4))
    (helm-do-grep)))

;; instant search across all buffers with helm
(defun instant-search-using-helm ()
  "multi-occur in all buffers backed by files."
  (interactive)
  (let ((helm-after-initialize-hook #'helm-follow-mode))
    (helm-multi-occur
     (delq nil
           (mapcar (lambda (b)
                     (when (buffer-file-name b) (buffer-name b)))
                   (buffer-list))))))

;; search all buffers using occur
(defun multi-occur-in-all-buffers (regexp &optional allbufs)
  "Show all lines matching REGEXP in all buffers."
  (interactive (occur-read-primary-args))
  (multi-occur-in-matching-buffers ".*" regexp))


;; wrap from behind
(defun paredit-wrap-round-from-behind ()
  (interactive)
  (forward-sexp -1)
  (paredit-wrap-round))


;; does exactly what it says
(defun duplicate-current-line-or-region (arg)
  "Duplicates the current line or region ARG times.
If there's no region, the current line will be duplicated. However, if
there's a region, all lines that region covers will be duplicated."
  (interactive "p")
  (let (beg end (origin (point)))
    (if (and mark-active (> (point) (mark)))
        (exchange-point-and-mark))
    (setq beg (line-beginning-position))
    (if mark-active
        (exchange-point-and-mark))
    (setq end (line-end-position))
    (let ((region (buffer-substring-no-properties beg end)))
      (dotimes (i arg)
        (goto-char end)
        (newline)
        (insert region)
        (setq end (point)))
      (goto-char (+ origin (* (length region) arg) arg)))))


;; unfill paragraph / region, reverse of fill-paragraph
(defun unfill-paragraph ()
  "Replace newline chars in current paragraph by single spaces.
This command does the reverse of `fill-paragraph'."
  (interactive)
  (let ((fill-column 90002000))
    (fill-paragraph nil)))

(defun unfill-region (start end)
  "Replace newline chars in region by single spaces.
This command does the reverse of `fill-region'."
  (interactive "r")
  (let ((fill-column 90002000))
    (fill-region start end)))


;; open recent files either with ido or normally
(defun ido-recentf-open-files (&optional arg)
  "Use ido to select a recently opened file from the `recentf-list'"
  (interactive "P")
  (if (eq (prefix-numeric-value arg) 4)
      (recentf-open-files)
      (let ((home (expand-file-name (getenv "HOME"))))
        (find-file
         (ido-completing-read "Recentf open: "
                              (mapcar (lambda (path)
                                        (replace-regexp-in-string home "~" path))
                                      recentf-list)
                              nil t)))))


;; automatically insert newline and indent when pressing RET inside parens
(setq skeleton-pair t)
(setq skeleton-pair-alist
      '((?\( _ ?\))
        (?[  _ ?])
        (?{  _ ?})
        (?\" _ ?\")))
(defun newline-and-indent-in-parens (arg)
  (interactive "P")
  (let (pair)
    (dolist (pair skeleton-pair-alist)
            (when (eq (char-after) (car (last pair)))
              (save-excursion (newline-and-indent))))
    (newline arg)
    (indent-according-to-mode)))


;; escreen wrappers
(defun escreen-get-active-screen-numbers-with-emphasis ()
  (interactive)
  (let ((escreens (escreen-get-active-screen-numbers))
        (emphased ""))

    (dolist (s escreens)
      (setq emphased
            (concat emphased
                    (if (= escreen-current-screen-number s)
                        (propertize (number-to-string (+ s 1))
                                    'face 'mode-line-buffer-id)
                      (number-to-string (+ s 1)))
                    " ")))
    emphased))

(defun escreen-echo-active-screen-numbers-with-emphasis ()
  (interactive)
  (message "escreen: %s" (escreen-get-active-screen-numbers-with-emphasis)))

(defun escreen-create-screen-dim ()
  (interactive)
  (escreen-create-screen)
  (escreen-echo-active-screen-numbers-with-emphasis))

(defun escreen-kill-screen-dim ()
  (interactive)
  (escreen-kill-screen)
  (escreen-echo-active-screen-numbers-with-emphasis))


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


;; beautify JSON
(defun beautify-json ()
  "Beautifies any region containing valid JSON data, using Python"
  (interactive)
  (when (use-region-p)
    (let (buf)
      (shell-command-on-region (mark) (point) "python -m json.tool" (current-buffer) t t))))


;; CSS color values colored by themselves
;; http://news.ycombinator.com/item?id=873541
(defvar hexcolor-keywords
  '(("#[abcdef[:digit:]]+"
     (0 (put-text-property
         (match-beginning 0)
         (match-end 0)
         'face (list :background
                     (match-string-no-properties 0)))))))

(defun hexcolor-add-to-font-lock ()
  (font-lock-add-keywords nil hexcolor-keywords))


;; diff two regions (https://gist.github.com/1279865)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; diff-region* - Diff two regions
;;
;; To compare two regions, select the first region
;; and run `diff-region`. The region is now copied
;; to a seperate diff-ing buffer. Next, navigate
;; to the next region in question (even in another file).
;; Mark the region and run `diff-region-now`, the diff
;; of the two regions will be displayed by ediff.
;;
;; You can re-select the first region at any time
;; by re-calling `diff-region`.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun diff-region ()
  "Select a region to compare"
  (interactive)
  (when (use-region-p) ; there is a region
        (let (buf)
          (setq buf (get-buffer-create "*Diff-regionA*"))
          (save-current-buffer
            (set-buffer buf)
            (erase-buffer))
          (append-to-buffer buf (region-beginning) (region-end)))
        )
  (message "Now select other region to compare and run `diff-region-now`")
  )

(defun diff-region-now ()
  "Compare current region with region already selected by `diff-region`"
  (interactive)
  (when (use-region-p)
        (let (bufa bufb)
          (setq bufa (get-buffer-create "*Diff-regionA*"))
          (setq bufb (get-buffer-create "*Diff-regionB*"))
          (save-current-buffer
            (set-buffer bufb)
            (erase-buffer))
          (append-to-buffer bufb (region-beginning) (region-end))
          (ediff-buffers bufa bufb))
        )
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


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

;; insert current date
(defun date ()
  (interactive)
  (insert (format-time-string "%a %b %-e %T IST %Y")))

;; insert HTML-encoded entity
(defun encode-html-entities (str)
  (interactive "sEncode: ")
  (insert (mapconcat
           (lambda (char)
             (format "&#%d;" char))
           (string-to-list str)
           "")))

(provide 'utils)
