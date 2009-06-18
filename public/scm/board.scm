;; NOTE: this is not used now (maybe will be needed for shaking?)
(define *tickets* (make-eq-hashtable))

(define (tickets-add! ticket)
  (hashtable-set! *tickets* (ticket 'id) ticket))

(define (tickets-get id)
  (hashtable-get *tickets* id))

(define (board-on-origin-clicked)
  (let* ((result (server-ticket-create!))
         (ticket (make-ticket (cdr result) "" 0 0)))
    (board-insert-ticket! ticket)
    (hand-show-ticket ticket)
    (hand-on-title-clicked)))

(define (board-insert-ticket! ticket)
  (tickets-add! ticket)
  (let1 div (ticket 'div)
    (set-position! div (+ (/ *width* 2) (ticket 'x))
                       (+ (/ *height* 2) (ticket 'y)))
    (element-insert! ($ "field") div)))

