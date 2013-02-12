You may have seen the `ido-everywhere' variable in ido.el and got
excited that you could use ido completion for everything. Then you
were probably disappointed when you realized that it only applied
to *file names* and nothing else. Well, ido-ubiquitous is here to
fulfill the original promise and let you use ido completion for
(almost) any command that uses `completing-read' to offer you a
choice of several alternatives.

This even works in M-x, but for that, you might prefer the "smex"
package instead.

As of version 0.7, this package also makes a small modification to
ido's behavior so as to support a strange corner case of
`completing-read' that some functions rely on. Since the goal of
this package is to replace `completing-read' everywhere instead of
just selectively (as ido itself does), compatibility with all the
quriks of `completing-read' is important here.

If you find a case where enabling ido-ubiquitous causes a command
not to work correctly, please report it by creating an issue on
GitHub: https://github.com/DarwinAwardWinner/ido-ubiquitous/issues
