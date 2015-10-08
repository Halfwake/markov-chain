;;;; mellon.asd

(asdf:defsystem #:markov-text
  :description "Describe  here"
  :author "Drew Dudash <drewd8@vt.edu>"
  :license "Specify license here"
  :serial t
  :depends-on (:cl-ppcre :alexandria)
  :components ((:file "package")
               (:file "markov-text")))
