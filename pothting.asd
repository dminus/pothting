(defsystem "pothting"
  :version "0.1.0"
  :author "George D. Hamilton"
  :license ""
  :depends-on ("clack"
               "lack"
               "caveman2"
               "envy"
               "cl-ppcre"
               "uiop"
               "woo"
               ;; for @route annotation
               "cl-syntax-annot"

               ;; HTML Template
               "djula"

               ;; for DB
               "mito"
               "mito-auth"
               "sxql")
  :components ((:module "src"
                :components
                ((:file "articles" :depends-on ("db" "authors"))
                 (:file "authors" :depends-on ("db"))
                 (:file "main" :depends-on ("config" "view" "db"))
                 (:file "web" :depends-on ("view"))
                 (:file "view" :depends-on ("config"))
                 (:file "db" :depends-on ("config"))
                 (:file "config"))))
  :description ""
  :in-order-to ((test-op (test-op "pothting-test"))))
