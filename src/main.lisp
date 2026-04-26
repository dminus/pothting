(in-package :cl-user)
(defpackage pothting
  (:use :cl)
  (:import-from :pothting.config
                :config)
  (:import-from :clack
                :clackup)
  (:export :start
           :quickstart
           :stop))
(in-package :pothting)

(defvar *appfile-path*
  (asdf:system-relative-pathname :pothting #P"app.lisp"))

(defvar *handler* nil)

(defun quickstart ()
  (start :server :woo :port :8899))

(defun start (&rest args &key server port debug &allow-other-keys)
  (declare (ignore server port debug))
  (when *handler*
    (restart-case (error "Server is already running.")
      (restart-server ()
        :report "Restart the server"
        (stop))))
  (setf *handler*
        (apply #'clackup *appfile-path* args)))

(defun stop ()
  (prog1
      (clack:stop *handler*)
    (setf *handler* nil)))
