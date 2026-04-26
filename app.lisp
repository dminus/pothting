(ql:quickload :pothting)

(defpackage pothting.app
  (:use :cl
        :mito)
  (:import-from :lack.builder
                :builder)
  (:import-from :ppcre
                :scan
                :regex-replace)
  (:import-from :pothting.web
                :*web*)
  (:import-from :pothting.config
                :config
                :productionp
                :*static-directory*))
(in-package :pothting.app)
(setf mito:*connection* (pothting.db:db))

(builder
 (:static
  :path (lambda (path)
          (if (ppcre:scan "^(?:/images/|/css/|/js/|/robots\\.txt$|/favicon\\.ico$)" path)
              path
              nil))
  :root *static-directory*)
 (:mito (pothting.db:connection-settings))
 (if (productionp)
     nil
     :accesslog)
 (if (getf (config) :error-log)
     `(:backtrace
       :output ,(getf (config) :error-log))
     nil)
 :session
 nil
 *web*)
