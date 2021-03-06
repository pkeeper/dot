(defvar my-packages '(starter-kit
                      starter-kit-lisp
                      starter-kit-bindings
                      starter-kit-eshell
                      clojure-mode
                      clojure-test-mode
                      nrepl
                      markdown-mode
                      erlang
                      python-mode))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))
