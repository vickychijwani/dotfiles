;; This file has my preferred color theme: color-theme-midnight, copied from color-theme-library.el

(defun color-theme-vicky ()
  "color-theme-midnight, copied from color-theme-library.el and renamed to
color-theme-vicky to avoid name clashes.

Color theme by Gordon Messmer, created 2001-02-07. A color theme inspired by a
certain IDE for Windows.  It's all from memory, since I only used that software
in college.

If you want to modify the font as well, you should customize variable
`color-theme-legal-frame-parameters' to \"\\(color\\|mode\\|font\\|height\\|width\\)$\".
The default setting will prevent color themes from installing specific fonts."
  (interactive)
  (color-theme-install
   '(color-theme-vicky
     ((font . "fixed")
      (width . 130)
      (height . 50)
      (background-color . "black")
      (foreground-color . "grey85")
      (background-mode . dark)
      (mouse-color . "grey85")
      (cursor-color . "grey85"))
     (default ((t (nil))))
     (font-lock-comment-face ((t (:italic t :foreground "grey60"))))
     (font-lock-string-face ((t (:foreground "Magenta"))))
     (font-lock-keyword-face ((t (:foreground "Cyan"))))
     (font-lock-warning-face ((t (:bold t :foreground "Pink"))))
     (font-lock-constant-face ((t (:foreground "OliveDrab"))))
     (font-lock-type-face ((t (:foreground "DarkCyan"))))
     (font-lock-variable-name-face ((t (:foreground "DarkGoldenrod"))))
     (font-lock-function-name-face ((t (:foreground "SlateBlue"))))
     (font-lock-builtin-face ((t (:foreground "SkyBlue"))))
     (highline-face ((t (:background "grey12"))))
     (setnu-line-number-face ((t (:background "Grey15" :foreground "White" :bold t))))
     (show-paren-match-face ((t (:background "grey30"))))
     (region ((t (:background "grey15"))))
     (highlight ((t (:background "blue"))))
     (secondary-selection ((t (:background "navy"))))
     (widget-field-face ((t (:background "navy"))))
     (widget-single-line-field-face ((t (:background "royalblue"))))
     (highlight-changes ((t (:foreground nil :background "#382f2f"))))
     (highlight-changes-delete ((t (:foreground nil :background "#916868")))))))

(provide 'color-theme-vicky)