(in-package :cl-user)
(defpackage pothting.view
  (:use :cl)
  (:import-from :pothting.config
                :*template-directory*)
  (:import-from :caveman2
                :*response*
                :response-headers)
  (:import-from :djula
                :add-template-directory
                :compile-template*
                :render-template*
                :*template-package*)
  (:export :render))
(in-package :pothting.view)

(djula:add-template-directory *template-directory*)

(defparameter *template-registry* (make-hash-table :test 'equal))

(defun render (template-path &optional env)
  (let ((template (gethash template-path *template-registry*)))
    (unless template
      (setf template (djula:compile-template* (princ-to-string template-path)))
      (setf (gethash template-path *template-registry*) template))
    (setf (getf env :user) (gethash :user caveman2:*session* nil))
    (apply #'djula:render-template*
          template nil
          env)))


;;
;; Execute package definition

(defpackage pothting.djula
  (:use :cl)
  (:import-from :pothting.config
                :config
                :appenv
                :developmentp
                :productionp)
  (:import-from :caveman2
                :url-for))

(setf djula:*template-package* (find-package :pothting.djula))
