(defpackage pothting.authors
  (:use :cl
        :pothting.db
        :mito
        :sxql)
  (:export :author
           :list-authors
           :setup-author-table))
(in-package :pothting.authors)

(use-package :mito-auth)

(defun list-authors ()
  (mito:select-dao 'author))

(mito:deftable author (has-secure-password) 
  ((nick :col-type (:varchar 64))
   (avatar :col-type (:binary)) ;; png?
   (email :col-type (:varchar 255))
   (bio :col-type (or (:text) :null)))
  (:unique-keys email nick))

(defun setup-author-table ()
  (mito:recreate-table 'author)
  (mito:create-dao 'author
    :nick "gdh"
    :avatar ""
    :email "george@ham.team"
    :bio "George D. Hamilton"
    :password "r3load"))
