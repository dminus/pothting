(defpackage pothting
  (:use :cl))
(in-package :pothting)

(defvar *server* nil
  "Server instance (Hunchentoot acceptor).")

(defparameter *port* 8899 "The application port.")
(defparameter *template-root* "
<title>Pothting</title>
  <body>
    <h1>Welcome to Pothting</h1>
    <hr>
    <ul>
      {% for article in articles %}
        <li>
        <a href=\"/article/{{ article.0 }}\">{{ article.1 }}</a>: {{ article.2 }}
        </li>
      {% endfor %}
    </ul>
  </body>
")


(defun render-articles ()
  (djula:render-template* 
    (djula:compile-string *template-root*)
    nil
    :articles (list-articles)))

(easy-routes:defroute root ("/" :method :get) ()
  (render-articles))

(easy-routes:defroute article-route ("/article/:n") ()
  (render-article n))

(defun start-server (&key (port *port*))
  (format t "~&Starting the web server on port ~a~&" port)
  (force-output)
  (setf *server* (make-instance 'easy-routes:easy-routes-acceptor
                                :port port))
  (hunchentoot:start *server*))
;; stuff
