(defpackage pothting.authors
  (:nicknames :pauth)
  (:use :cl
        :pothting.db
        :mito
        :mito-auth
   :sxql
   :assoc-utils)
  (:export :author
           :list-authors
           :author-plist
           :validate-login
           :fetch-author-by-id
           :fetch-author-by-email
           :setup-author-table))
(in-package :pothting.authors)

(use-package :mito-auth)

(mito:deftable author (has-secure-password)
  ((nick :col-type (:varchar 64))
   (avatar :col-type (:binary)) ;; png?
   (email :col-type (:varchar 255))
   (bio :col-type (or (:text) :null)))
  (:unique-keys email nick))


(defun validate-login (login)
  (let ((user (fetch-author-by-email (aget login "username"))))
    (if (auth user (aget login "password"))
        (cons `:ok (setf (gethash :user caveman2:*session*) (author-plist user)))
        (cons :error nil))))

(defun author-plist (user)
  (list :email (author-email user)
        :bio (author-bio user)
        :nick (author-nick user)
        :id (mito:object-id user)))

(defun fetch-author-by-id (id)
  (mito:find-dao 'author :id id))

(defun fetch-author-by-email (email)
  (mito:find-dao 'author :email email))

(defun list-authors ()
  (mito:select-dao 'author))

(defun setup-author-table ()
  (mito:recreate-table 'author)
  (mito:create-dao 'author
    :nick "gdh"
    :avatar ""
    :email "george@ham.team"
    :bio "George D. Hamilton"
    :password "r3load"))

