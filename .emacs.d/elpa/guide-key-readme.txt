Overview:

guide-key.el enables to guide the following key bindings automatically and
dynamically. guide-key aims to be an alternative of one-key.el.

Here are some features of this library.
- guide-key automatically pop up the keys following your favorite
  prefixes. Moreover, even if you change key bindings, guide-key follows its
  change dynamically.
- guide-key can highlight particular commands. This makes it easy to find a
  command you are looking for, and to learn its key binding.
- guide-key doesn't overwrite existing commands and key bindings. So, there
  is no bad effect on using `describe-key' and `describe-bindings'.


Installation:

I added guide-key to MELPA. You can install guide-key with package.el,
Because guide-key depends on popwin.el, popwin.el is also installed at a
time.

If you don't have package.el, please download popwin.el and guide-key.el
directly from https://github.com/m2ym/popwin-el and
https://github.com/kbkbkbkb1/guide-key, and then put them in your
`load-path'.


Basic usage:

You just add your favorite prefix keys to `guide-key/guide-key-sequence'
as below.

  (require 'guide-key)
  (setq guide-key/guide-key-sequence '("C-x r" "C-x 4"))
  (guide-key-mode 1) ; Enable guide-key-mode

When you press these "C-x r" or "C-x 4", key bindings are automatically
popped up.

guide-key can highlight commands which match a specified regular
expression.  Key bindings following "C-x r" are rectangle family and
register family.  If you want to highlight only rectangle family commands,
put this setting in your init.el.

  (setq guide-key/highlight-command-regexp "rectangle")

This feature makes it easy to find commands and learn their key bindings. If
you want to highlight both rectangle family and register family, set an
adequate regular expression like this.

  (setq guide-key/highlight-command-regexp "rectangle\\|register")

Moreover, prefix commands are automatically highlighted.

I've confirmed that guide-key works well in these environments.
- Emacs 24.2, Ubuntu 12.04 or Windows 7 64bit
- Emacs 23.3, Ubuntu 12.04 or Windows 7 64bit
- Emacs 22.3, Windows 7 64bit
If popwin works good, I think guide-key also works good. You can use
guide-key with Emacs working in terminal.


Advanced usage:

It is bothering to add many prefixes to `guide-key/guide-key-sequence'.
`guide-key/recursive-key-sequence-flag' releases you from this problem.
If `guide-key/recursive-key-sequence-flag' is non-nil, guide-key checks a
input key sequence recursively. That is, if "C-x 8 ^" is an input key
sequence, guide-key checks whether `guide-key/guide-key-sequence' includes
"C-x 8" and "C-x".

For example, if you configure as below,

  (setq guide-key/guide-key-sequence '("C-x"))
  (setq guide-key/recursive-key-sequence-flag t)

guide buffer is popped up when you input "C-x r", "C-x 8" and
any other prefixes following "C-x".


You can add extra settings in a particular mode. Please use
`guide-key/add-local-guide-key-sequence',
`guide-key/add-local-highlight-command-regexp' and hook of
that mode.


This code is a example of org-mode.

  (defun guide-key/my-hook-function-for-org-mode ()
    (guide-key/add-local-guide-key-sequence "C-c")
    (guide-key/add-local-guide-key-sequence "C-c C-x")
    (guide-key/add-local-highlight-command-regexp "org-"))
  (add-hook 'org-mode-hook 'guide-key/my-hook-function-for-org-mode)


Here are some functions and variables which control guide-key.
- `guide-key-mode':
   guide-key-mode is implemented as a minor mode.
   Excuting M-x guide-key-mode toggles whether guide-key is enabled or
   not.  Because guide-key-mode is a global minor mode, guide-key-mode is
   enabled in all buffers or disabled in all buffers.
- `guide-key/popup-window-position':
  This variable controls where a guide-key buffer is popped up. A value of
  this variable is one of `right', `bottom', `left', `top'. The default
  value is `right'.
- `guide-key/polling-time':
   This variable controls a polling time. The default value is 0.1 (in seconds).


Enjoy!
