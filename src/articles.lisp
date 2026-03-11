(in-package :pothting)
(defun articles (&optional (n 5))
  (loop for i from 0 below n 
        collect (list i
                      (format nil "Article (id: ~a)" i)
                      "2026-03-09 09:33:00 -0600")))
