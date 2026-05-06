(defpackage pothting.articles
  (:nicknames :pcont)
  (:use :cl
        :caveman2
        :pothting.db
        :mito
        :sxql)
  (:import-from
        :pothting.authors)
  (:export :article
   :fetch-article
   :post-article
   :list-articles
   :article-renderable
   :setup-article-table))
(in-package :pothting.articles)

(defun list-articles ()
  (mito:retrieve-by-sql (select (:article.*) (from :article) (order-by (:desc :id)))))

(mito:deftable article ()
  ((title :col-type (:varchar 255))
   (body :col-type (:text))
   (authored-by :col-type :integer :references (pothting.authors:author id))))

(defun setup-article-table ()
  (recreate-table 'article)
  (migrate-table 'article))

(defun post-article (&key authored-by title body)
  (create-dao 'article :title title :body body :authored-by authored-by))

(defun q-article-base ()
  '(select
    (:article.* (:as :author.nick :author_nick))
    (from :article)
    (left-join
     (:as 'pothting.authors:author :author)
     :on (:= :article.authored_by :author.id)
     )
    )
  )

(defun fetch-article (&optional (id nil))
   (mito:retrieve-by-sql
    (select (:article.* (:as :author.nick :author_nick) (:as :author.id :author_id))
      (from :article)
      (left-join (:as 'pothting.authors:author :author) :on (:= :article.authored_by :author.id))
      (order-by (:desc :id))
      (if (null id)
          (limit 10)
          (where (:= :article.id id))))))
