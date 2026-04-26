(defsystem "pothting-test"
  :defsystem-depends-on ("prove-asdf")
  :author "George D. Hamilton"
  :license ""
  :depends-on ("pothting"
               "prove")
  :components ((:module "tests"
                :components
                ((:test-file "pothting"))))
  :description "Test system for pothting"
  :perform (test-op (op c) (symbol-call :prove-asdf :run-test-system c)))
