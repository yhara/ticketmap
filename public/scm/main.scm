;;;
;;; main.scm
;;;

;; load
(for-each (lambda (pair)
            (js-load (string-append "js/" (car pair) ".js")
                     (cdr pair)))
          '(("scriptaculous" . "Scriptaculous")
            ("builder" . "Builder")
            ("effects" . "Effect")
            ("dragdrop" . "Draggable")
            ("controls" . "Autocompleter")
            ("slider" . "Control")
            ("sound" . "Sound")))

(load "scm/ticket.scm")
(load "scm/board.scm")
(load "scm/hand.scm")
(load "scm/server.scm")

;; consts

(define (px n)
  (string-append (number->string n) "px"))

(define (set-position! elem x y)
  (set-style! elem "position" "absolute") 
  (set-style! elem "left" (px x))
  (set-style! elem "top" (px y)))

(define (get-position elem)
  (define (remove-px str)
    (string->number (car (regexp-exec "(\\d+)" str))))
  (values (remove-px (get-style elem "left"))
          (remove-px (get-style elem "top"))))

(define *width* #f)
(define *height* #f)

;; util
(define show-error print)

;; initialize
(let1 result (read-from-string (http-request "config/board_size"))
  (if (eq? (car result) 'xy)
    (begin
      (set! *width*  (cadr result))
      (set! *height* (cddr result)))
    (show-error "error: failed to load board size")))

(set-style! ($ "field") "width" (px *width*))
(set-style! ($ "field") "height" (px *height*))
(set-position! ($ "top")    (/ *width* 2) 0)
(set-position! ($ "bottom") (/ *width* 2) *height*)
(set-position! ($ "right")  *width* (/ *height* 2))
(set-position! ($ "left")   0       (/ *height* 2))
(set-position! ($ "origin") (/ *width* 2) (/ *height* 2))

(add-handler! ($ "origin") "click" board-on-origin-clicked)

(add-handler! ($ "hand_title") "click" hand-on-title-clicked)
(add-handler! ($ "hand_delete") "click" hand-on-delete-clicked)

(for-each (lambda (vals) 
            (board-insert-ticket! (apply make-ticket vals)))
          (server-ticket-list))

(display "ok")
