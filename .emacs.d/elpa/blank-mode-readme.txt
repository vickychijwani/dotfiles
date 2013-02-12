;;; Commentary:

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Introduction
;; ------------
;;
;; This package is a minor mode to visualise blanks (SPACE, HARD SPACE and
;; TAB).
;;
;; blank-mode uses two ways to visualise blanks: faces and display table.
;;
;; Faces are used to highlight the background with a color.  blank-mode uses
;; font-lock to highlight blank characters.
;;
;; Display table change the way a character is displayed, that is, it provides
;; a visual mark for characters, for example, at the end of line (?\xB6), at
;; spaces (?\xB7) and at tabs (?\xBB).
;;
;; The `blank-style' and `blank-chars' variables are used to select which way
;; should be used to visualise blanks.
;;
;; To use blank-mode, insert in your ~/.emacs:
;;
;;    (require 'blank-mode)
;;
;; Or:
;;
;;    (autoload 'blank-mode-on         "blank-mode"
;;      "Turn on blank visualisation."         t)
;;    (autoload 'blank-mode-off        "blank-mode"
;;      "Turn off blank visualisation."        t)
;;    (autoload 'blank-mode            "blank-mode"
;;      "Toggle blank visualisation."          t)
;;    (autoload 'blank-global-mode-on  "blank-mode"
;;      "Turn on blank mode in every buffer."  t)
;;    (autoload 'blank-global-mode-off "blank-mode"
;;      "Turn off blank mode in every buffer." t)
;;    (autoload 'blank-global-mode     "blank-mode"
;;      "Toggle blank mode in every buffer."   t)
;;    (autoload 'blank-mode-customize  "blank-mode"
;;      "Customize blank visualisation."       t)
;;
;; For good performance, be sure to byte-compile blank-mode.el, e.g.
;;
;;    M-x byte-compile-file <give the path to blank-mode.el when prompted>
;;
;; This will generate blank-mode.elc, which will be loaded instead of
;; blank-mode.el.
;;
;; blank-mode was tested with GNU Emacs 20.6.1, 21 and 22.
;;
;;
;; Using blank-mode
;; ----------------
;;
;; There is no problem if you mix local and global minor mode usage.
;;
;; * To customize blank-mode, type:
;;
;;    M-x blank-mode-customize RET
;;
;; * LOCAL blank-mode:
;;    + To activate blank-mode locally, type:
;;
;;         M-x blank-mode-on RET
;;
;;      Or:
;;
;;         C-u 1 M-x blank-mode RET
;;
;;    + To deactivate blank-mode locally, type:
;;
;;         M-x blank-mode-off RET
;;
;;      Or:
;;
;;         C-u 0 M-x blank-mode RET
;;
;;    + To toggle blank-mode locally, type:
;;
;;         M-x blank-mode RET
;;
;; * GLOBAL blank-mode:
;;    + To activate blank-mode globally, type:
;;
;;         M-x blank-global-mode-on RET
;;
;;      Or:
;;
;;         C-u 1 M-x blank-global-mode RET
;;
;;    + To deactivate blank-mode globally, type:
;;
;;         M-x blank-global-mode-off RET
;;
;;      Or:
;;
;;         C-u 0 M-x blank-global-mode RET
;;
;;    + To toggle blank-mode globally, type:
;;
;;         M-x blank-global-mode RET
;;
;; You can also bind `blank-mode', `blank-mode-on', `blank-mode-off',
;; `blank-global-mode', `blank-global-mode-on', `blank-global-mode-off' and
;; `blank-mode-customize' to some key, like:
;;
;;    (global-set-key "\C-c\C-a" 'blank-mode-on)
;;    (global-set-key "\C-c\C-b" 'blank-mode-off)
;;    (global-set-key "\C-c\C-l" 'blank-mode)
;;    (global-set-key "\C-c\C-d" 'blank-global-mode-on)
;;    (global-set-key "\C-c\C-e" 'blank-global-mode-off)
;;    (global-set-key "\C-c\C-g" 'blank-global-mode)
;;    (global-set-key "\C-c\C-c" 'blank-mode-customize)
;;
;;
;; Hooks
;; -----
;;
;; blank-mode has the following hook variables:
;;
;; `blank-mode-hook'
;;    It is evaluated always when blank-mode is turned on locally.
;;
;; `blank-global-mode-hook'
;;    It is evaluated always when blank-mode is turned on globally.
;;
;; `blank-load-hook'
;;    It is evaluated after blank-mode package is loaded.
;;
;;
;; Options
;; -------
;;
;; Below it's shown a brief description of blank-mode options, please, see the
;; options declaration in the code for a long documentation.
;;
;; `blank-verbose'		Non-nil means generate messages.
;;
;; `blank-style'		Specify the visualisation style.
;;
;; `blank-chars'		Specify which kind of blank is visualised.
;;
;; `blank-space-face'		Face used to visualise SPACE.
;;
;; `blank-hspace-face'		Face used to visualise HARD SPACE.
;;
;; `blank-tab-face'		Face used to visualise TAB.
;;
;; `blank-map-face'		Face used to visualise NEWLINE char mapping.
;;
;; `blank-trailing-face'	Face used to visualise trailing blanks.
;;
;; `blank-line-face'		Face used to visualise "long" lines.
;;
;; `blank-space-before-tab-face'	Face used to visualise space before tab.
;;
;; `blank-space-regexp'		Specify space characters regexp.
;;
;; `blank-hspace-regexp'	Specify hard space characters regexp.
;;
;; `blank-tab-regexp'		Specify tab characters regexp.
;;
;; `blank-trailing-regexp'	Specify trailing characters regexp.
;;
;; `blank-space-before-tab-regexp'	Specify space before tab regexp.
;;
;; `blank-line-length'		Specify length beyond which the line is
;;				highlighted.
;;
;; `blank-display-mappings'	Specify an alist of mappings for displaying
;;				characters.
;;
;; `blank-global-modes'		Modes for which global `blank-mode' is
;;				automagically turned on.
;;
;; To set the above options you may:
;;
;; a) insert the code in your ~/.emacs, like:
;;
;;	 (setq blank-space-face 'underline)
;;
;;    This way always keep your default settings when you enter a new Emacs
;;    session.
;;
;; b) or use `set-variable' in your Emacs session, like:
;;
;;	 M-x set-variable RET blank-space-face RET underline RET
;;
;;    This way keep your settings only during the current Emacs session.
;;
;; c) or use customization, for example:
;;	 click on menu-bar *Help* option,
;;	 then click on *Customize*,
;;	 then click on *Browse Customization Groups*,
;;	 expand *Data* group,
;;	 expand *Blank* group
;;	 and then customize blank-mode options.
;;    Through this way, you may choose if the settings are kept or not when
;;    you leave out the current Emacs session.
;;
;; d) or see the option value:
;;
;;	 C-h v blank-space-face RET
;;
;;    and click the *customize* hypertext button.
;;    Through this way, you may choose if the settings are kept or not when
;;    you leave out the current Emacs session.
;;
;; e) or invoke:
;;
;;	 M-x blank-mode-customize RET
;;
;;    and then customize blank-mode options.
;;    Through this way, you may choose if the settings are kept or not when
;;    you leave out the current Emacs session.
;;
;;
;; Acknowledgements
;; ----------------
;;
;; Thanks to Antti Kaihola <antti.kaihola@linux-aktivaattori.org> for helping
;; to fix `find-file-hooks' reference.
;;
;; Thanks to Andreas Roehler <andreas.roehler@easy-emacs.de> for indicating
;; defface byte-compilation warnings.
;;
;; Thanks to TimOCallaghan (EmacsWiki) for the idea about highlight "long"
;; lines. See EightyColumnRule (EmacsWiki).
;;
;; Thanks to Yanghui Bian <yanghuibian@gmail.com> for indicating a new
;; newline character mapping.
;;
;; Thanks to Pete Forman <pete.forman@westgeo.com> for indicating
;; whitespace-mode on XEmacs.
;;
;; Thanks to:
;;    Aurelien Tisne <aurelien.tisne@free.fr>	show-whitespace-mode.el
;;    Lawrence Mitchell <wence@gmx.li>		whitespace-mode.el
;;    Miles Bader <miles@gnu.org>		visws.el
;; And to all people who contributed with them.
;;
;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
