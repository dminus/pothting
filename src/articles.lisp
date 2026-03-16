(in-package :pothting)
(defun list-articles (&optional (n 5))
  (loop for i from 0 below n 
        collect (list i
                      (format nil "Article (id: ~a)" i)
                      "2026-03-09 09:33:00 -0600")))

(defun render-article (n) (format nil "article id ~a" n))

(mito:deftable author () 
  ((nick :col-type (:varchar 64))
   (email :col-type (:varchar 255))
   (bio :col-type (or (:text) :null))

(mito:deftable article ()
  ((title :col-type (:varchar 255))
   (body :col-type (:text))
   (author :col-type (:author))

