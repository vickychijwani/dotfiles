;;; hideshowvis-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (hideshowvis-symbols hideshowvis-enable hideshowvis-minor-mode
;;;;;;  hideshowvis-click-fringe) "hideshowvis" "hideshowvis.el"
;;;;;;  (20716 9061))
;;; Generated autoloads from hideshowvis.el

(autoload 'hideshowvis-click-fringe "hideshowvis" "\


\(fn EVENT)" t nil)

(autoload 'hideshowvis-minor-mode "hideshowvis" "\
Toggle Hideshowvis minor mode on or off.
With a prefix argument ARG, enable Hideshowvis minor mode if ARG is
positive, and disable it otherwise.  If called from Lisp, enable
the mode if ARG is omitted or nil, and toggle it if ARG is `toggle'.
\\{hideshowvis-mode-map}

\(fn &optional ARG)" t nil)

(autoload 'hideshowvis-enable "hideshowvis" "\
Will enable hideshowvis minor mode

\(fn)" t nil)

(autoload 'hideshowvis-symbols "hideshowvis" "\
Defines the things necessary to get a + symbol in the fringe
and a yellow marker indicating the number of hidden lines at
the end of the line for hidden regions.

\(fn)" t nil)

;;;***

;;;### (autoloads nil nil ("hideshowvis-pkg.el") (20716 9062 13033))

;;;***

(provide 'hideshowvis-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; hideshowvis-autoloads.el ends here
