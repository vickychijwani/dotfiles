;;; yasnippet-bundle.el --- Yet another snippet extension (Auto compiled bundle)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;      Auto-generated code         ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun yas/initialize-bundle ()
  "Initialize YASnippet and load snippets in the bundle.";;; snippets for nxml-mode
(yas/define-snippets 'nxml-mode
                     '(("body" "#contributor : Anders Bach Nielsen <abachn@abachn.net>\n#name : <body>...</body>\n# --\n<body$1>\n  $0\n</body>" "body" nil nil nil nil nil)
                       ("br" "#contributor : Anders Bach Nielsen <abachn@abachn.net>\n#name : <br />\n# --\n<br />" "br" nil nil nil nil nil)
                       ("code" "#contributor : Anders Bach Nielsen <abachn@abachn.net>\n#name : <code>...</code>\n# --\n<code>\n  $0\n</code>" "code" nil nil nil nil nil)
                       ("div" "<div$1>$0</div>" "<div...>...</div>" nil nil nil nil nil)
                       ("doctype" "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.1//EN\" \"http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd\">" "DocType XHTML 1.1" nil "meta" nil nil nil)
                       ("doctype" "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">" "DocType XHTML 1.0 Strict" nil "meta" nil nil nil)
                       ("doctype" "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">" "DocType XHTML 1.0 Transitional" nil "meta" nil nil nil)
                       ("form" "#contributor : Anders Bach Nielsen <abachn@abachn.net>\n#name :<form method=\"...\" action=\"...\"></form>\n# --\n<form method=\"$1\" action=\"$2\">\n  $0\n</form>" "form" nil nil nil nil nil)
                       ("h1" "#contributor : Anders Bach Nielsen <abachn@abachn.net>\n#name : <h1>...</h1>\n#group : header\n# --\n<h1>$1</h1>" "h1" nil nil nil nil nil)
                       ("h2" "#contributor : Anders Bach Nielsen <abachn@abachn.net>\n#name : <h2>...</h2>\n#group : header\n# --\n<h2>$1</h2>" "h2" nil nil nil nil nil)
                       ("h3" "#contributor : Anders Bach Nielsen <abachn@abachn.net>\n#name : <h3>...</h3>\n#group : header\n# --\n<h3>$1</h3>" "h3" nil nil nil nil nil)
                       ("h4" "#contributor : Anders Bach Nielsen <abachn@abachn.net>\n#name : <h4>...</h4>\n#group : header\n# --\n<h4>$1</h4>" "h4" nil nil nil nil nil)
                       ("h5" "#contributor : Anders Bach Nielsen <abachn@abachn.net>\n#name : <h5>...</h5>\n#group : header\n# --\n<h5>$1</h5>" "h5" nil nil nil nil nil)
                       ("h6" "#contributor : Anders Bach Nielsen <abachn@abachn.net>\n#name : <h6>...</h6>\n#group : header\n# --\n<h6>$1</h6>" "h6" nil nil nil nil nil)
                       ("head" "#contributor : Anders Bach Nielsen <abachn@abachn.net>\n#name : <head>...</head>\n# --\n<head>\n  $0\n</head>" "head" nil nil nil nil nil)
                       ("hr" "#contributor : Anders Bach Nielsen <abachn@abachn.net>\n#name : <hr />\n# --\n<hr />\n" "hr" nil nil nil nil nil)
                       ("href" "#contributor : Anders Bach Nielsen <abachn@abachn.net>\n#name : <a href=\"...\">...</a>\n# --\n<a href=\"$1\">$2</a>" "href" nil nil nil nil nil)
                       ("html" "#contributor : Anders Bach Nielsen <abachn@abachn.net>\n#name : <html xmlns=\"...\">...</html>\n# --\n<html xmlns=\"http://www.w3.org/1999/xhtml\" xml:lang=\"${1:en}\" lang=\"${2:en}\">\n  $0\n</html>\n" "html" nil nil nil nil nil)
                       ("img" "#contributor : Anders Bach Nielsen <abachn@abachn.net>\n#name : <img src=\"...\" alt=\"...\" />\n# --\n<img src=\"$1\" alt=\"$2\" />" "img" nil nil nil nil nil)
                       ("input" "#contributor : Anders Bach Nielsen <abachn@abachn.net>\n#name : <input ... />\n# --\n<input type=\"$1\" name=\"$2\" value=\"$3\" />" "input" nil nil nil nil nil)
                       ("li" "#contributor : Anders Bach Nielsen <abachn@abachn.net>\n#name : <li>...</li>\n# --\n<li>$1</li>" "li" nil nil nil nil nil)
                       ("link" "#contributor : Anders Bach Nielsen <abachn@abachn.net>\n#name : <link stylesheet=\"...\" />\n# --\n<link rel=\"${1:stylesheet}\" href=\"${2:url}\" type=\"${3:text/css}\" media=\"${4:screen}\" />" "link" nil nil nil nil nil)
                       ("meta" "#contributor : Anders Bach Nielsen <abachn@abachn.net>\n#name : <meta name=\"...\" content=\"...\" />\n#group : meta\n# --\n<meta name=\"${1:generator}\" content=\"${2:content}\" />" "meta" nil nil nil nil nil)
                       ("name" "#contributor : Anders Bach Nielsen <abachn@abachn.net>\n#name : <a name=\"...\"></a>\n# --\n<a name=\"$1\"></a>" "name" nil nil nil nil nil)
                       ("ol" "#contributor : Anders Bach Nielsen <abachn@abachn.net>\n#name : <ol>...</ol>\n# --\n<ol>\n  $0\n</ol>" "ol" nil nil nil nil nil)
                       ("p" "#contributor : Anders Bach Nielsen <abachn@abachn.net>\n#name : <p>...</p>\n# --\n<p>$1</p>" "p" nil nil nil nil nil)
                       ("pre" "#contributor : Anders Bach Nielsen <abachn@abachn.net>\n#name : <pre>...</pre>\n# --\n<pre>\n  $0\n</pre>" "pre" nil nil nil nil nil)
                       ("quote" "#contributor : Anders Bach Nielsen <abachn@abachn.net>\n#name : <blockquote>...</blockquote>\n# --\n<blockquote>\n  $1\n</blockquote>" "quote" nil nil nil nil nil)
                       ("span" "#contributor : Anders Bach Nielsen <abachn@abachn.net>\n#name : <span>...</span>\n# --\n<span>$1</span>" "span" nil nil nil nil nil)
                       ("style" "#contributor : Anders Bach Nielsen <abachn@abachn.net>\n#name : <style type=\"text/css\" media=\"...\">...</style>\n# --\n<style type=\"text/css\" media=\"${1:screen}\">\n  $0\n</style>" "style" nil nil nil nil nil)
                       ("table" "#contributor : Anders Bach Nielsen <abachn@abachn.net>\n#name : <table>...</table>\n# --\n<table>\n  $0\n</table>" "table" nil nil nil nil nil)
                       ("tag" "<${1:tag}>$2</$1>$0" "<tag>...</tag>" nil nil nil nil nil)
                       ("tag" "<${1:tag}>\n  $2\n</$1>$0" "<tag> \\n...\\n</tag>" nil nil nil nil nil)
                       ("td" "#contributor : Anders Bach Nielsen <abachn@abachn.net>\n#name : <td>...</td>\n# --\n<td$1>$2</td>" "td" nil nil nil nil nil)
                       ("th" "#contributor : Anders Bach Nielsen <abachn@abachn.net>\n#name : <th>...</th>\n# --\n<th$1>$2</th>" "th" nil nil nil nil nil)
                       ("title" "#contributor : Anders Bach Nielsen <abachn@abachn.net>\n#name : <title>...</title>\n# --\n<title>$1</title>" "title" nil nil nil nil nil)
                       ("tr" "#contributor : Anders Bach Nielsen <abachn@abachn.net>\n#name : <tr>...</tr>\n# --\n<tr>\n  $0\n</tr>" "tr" nil nil nil nil nil)
                       ("ul" "#contributor : Anders Bach Nielsen <abachn@abachn.net>\n#name : <ul>...</ul>\n# --\n<ul>\n  $0\n</ul>" "ul" nil nil nil nil nil))
                     'nil)


;;; snippets for scheme-mode
(yas/define-snippets 'scheme-mode
                     '(("cond" "(cond ($1)$2)" "cond" nil nil nil nil nil)
                       ("define" "(define ($1)\n$2)" "define" nil nil nil nil nil))
                     'nil)


(yas/global-mode 1)
)

(yas/initialize-bundle)
;;;###autoload(require 'yasnippet-bundle)
(set-default 'yas/dont-activate
             #'(lambda nil
                 (and
                  (or yas/root-directory
                      (featurep '\.yas-scheme-mode-snippets))
                  (null
                   (yas/get-snippet-tables)))))
(provide '\.yas-scheme-mode-snippets)
;;; .yas-scheme-mode-snippets.el ends here
