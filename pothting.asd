(asdf:defsystem "pothting"
  :version "0.1"
  :author "me"
  :license "WTFPL"
  :depends-on (
               ;; web stack
               :hunchentoot  ;; web server
               :easy-routes  ;; routes facility
               :djula        ;; HTML templates
               )
  :components ((:module "src"  ;; a src/ subdirectory
                :components
                (
                 (:file "pothting") ;; = src/pothting.lisp
                )))

  :description "A list of products")
