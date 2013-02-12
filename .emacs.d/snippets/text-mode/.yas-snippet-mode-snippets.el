(yas/define-snippets 'snippet-mode
                     '(("$f" "\\${${1:${2:n}:}$3${4:\\$(${5:lisp-fn})}\\}$0" "${ ...  } field" nil nil nil nil nil)
                       ("$m" "\\${${2:n}:${4:\\$(${5:reflection-fn})}\\}$0" "${n:$(...)} mirror" nil nil nil nil nil)
                       ("vars" "# name : $1${2:\n# key : ${3:expand-key}}${4:\n# group : ${5:group}} \n# contributor : $6\n# --\n$0" "Snippet header" nil nil nil nil nil))
                     'nil)