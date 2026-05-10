(in-package :cl-user)
(defpackage pothting.web
  (:nicknames :pweb)
  (:import-from :pothting.articles :article)
  (:import-from :pothting.authors :author :validate-login :author-plist)
  (:use :cl
        :caveman2
        :pothting.config
        :pothting.view
        :pothting.db
        :djula
        :mito
        :mito-auth
        :sxql
        :assoc-utils
        )
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

(defroute "/" (&key (|before| nil))
  (render #P"articles.tpl"
          (list :articles
                (if (null |before|)
                    (pothting.articles:fetch-article)
                    (pothting.articles:fetch-article :before-id |before|)))))

(defroute ("/about" :method :GET) ()
  (render #P"about.tpl"))

(defroute ("/profile" :method :GET) ()
  (auth-required
    (render #P"profile.tpl" (list :target_user (gethash :user *session*)))))

(defroute ("/profile/:id" :method :GET) (&key id)
  (render #P"profile.tpl"
          (list
           :target_user (author-plist (pothting.authors:fetch-author-by-id id))
           )))

(defroute ("/login" :method :GET) ()
  (render #P"login.tpl"))

(defroute ("/login" :method :POST) (&key _parsed)
  (if (validate-login (aget _parsed "login"))
      (redirect "/" 302)
      (render #P"login.tpl" (list :error "Authentication failed"))))

(defroute ("/logout") ()
    (setf (gethash :user *session*) nil)
    (redirect "/" 302))

(defun logged-in-p ()
  (gethash :user *session*))

(defmacro auth-required (&body body)
  `(if (logged-in-p)
      (progn ,@body)
      (render #P"login.tpl" '(:message "Login required"))))

(defun logout ()
  (setf (gethash :user *session*) nil)
  (redirect "/"))

(defroute ("/article/new" :method :GET) ()
  (auth-required
  (render #P"article-new.tpl")))

(defroute ("/article/new" :method :POST) (&key _parsed)
  (auth-required
    (redirect
     (format nil "/article/~D"
             (mito:object-id
              (create-dao 'pothting.articles:article
                          :body (cdr (assoc "body" _parsed :test #'string=))
                          :title (cdr (assoc "title" _parsed :test #'string=))
                          :authored-by (getf (gethash :user *session*) :id)))) 302)))


(defroute "/article/:id" (&key id)
  (let ((target-article (pothting.articles:fetch-article :id id)))
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
