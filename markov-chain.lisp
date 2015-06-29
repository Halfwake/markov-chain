(defpackage :markov-text
  (:use :common-lisp
	:cl-ppcre
	:alexandria))

(in-package :markov-text)

(defparameter *stochastic-matrix* (make-hash-table :test #'equalp))

(defun increment-table (first-word second-word)
  (ensure-gethash first-word *stochastic-matrix*
		  '())
  (push second-word (gethash first-word *stochastic-matrix*)))

(defparameter *text* "CHAPTER I. Down the Rabbit-Hole

Alice was beginning to get very tired of sitting by her sister on the
bank, and of having nothing to do: once or twice she had peeped into the
book her sister was reading, but it had no pictures or conversations in
it, 'and what is the use of a book,' thought Alice 'without pictures or
conversations?'

So she was considering in her own mind (as well as she could, for the
hot day made her feel very sleepy and stupid), whether the pleasure
of making a daisy-chain would be worth the trouble of getting up and
picking the daisies, when suddenly a White Rabbit with pink eyes ran
close by her.

There was nothing so VERY remarkable in that; nor did Alice think it so
VERY much out of the way to hear the Rabbit say to itself, 'Oh dear!
Oh dear! I shall be late!' (when she thought it over afterwards, it
occurred to her that she ought to have wondered at this, but at the time
it all seemed quite natural); but when the Rabbit actually TOOK A WATCH
OUT OF ITS WAISTCOAT-POCKET, and looked at it, and then hurried on,
Alice started to her feet, for it flashed across her mind that she had
never before seen a rabbit with either a waistcoat-pocket, or a watch
to take out of it, and burning with curiosity, she ran across the field
after it, and fortunately was just in time to see it pop down a large
rabbit-hole under the hedge.")

(defun split-text (text)
  (cl-ppcre:split "[\\s:.?!,();']+" text))

(let ((word-list (split-text *text*)))
  (loop for word-one in word-list
     for word-two in (append (cdr word-list)
			     (list (car word-list)))
     do (increment-table word-one word-two)))

(defun generate-text (n)
  (labels ((iterate (word n)
	     (if (zerop n)
		 '()
		 (cons word
		       (iterate (random-elt (gethash word *stochastic-matrix*))
				(1- n))))))
    (let ((first-word (random-elt (hash-table-keys *stochastic-matrix*))))
      (iterate first-word n))))

