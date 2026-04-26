(in-package :cl-user)
(defpackage pothting.web
  (:use :cl
        :caveman2
        :pothting.config
        :pothting.view
        :pothting.db
        :pothting.articles
        :djula
        :mito
        :sxql)
  (:export :*web*))
(in-package :pothting.web)

;; for @route annotation
(syntax:use-syntax :annot)

;;
;; Application

(defclass <web> (<app>) ())
(defvar *web* (make-instance '<web>))
(clear-routing-rules *web*)

;;
;; Routing rules

(defroute "/" ()
  (render #P"articles.tpl" (list :articles (pothting.articles:fetch-article))))

(defroute "/article/:id" (&key id)
  (let ((target-article (pothting.articles:fetch-article id)))
  (if (null target-article)
      (throw-code 404)
      (render #P"article.tpl" (list :viewed-article (first target-article))))))

;;
;; Error pages

(defmethod on-exception ((app <web>) (code (eql 404)))
  (declare (ignore app))
  (merge-pathnames #P"_errors/404.html"
                   *template-directory*))

(djula:def-filter :md2html (body)
  (with-output-to-string (s)
    (3bmd:parse-string-and-print-to-stream body s)))
