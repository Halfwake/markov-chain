(defpackage :markov-text
  (:use :common-lisp
	:cl-ppcre
	:alexandria)
  (:export :make-markov-text-generator))
