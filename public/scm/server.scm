(define (server-request url . params)
  (define (params->alist list)
    (cond
      ((null? list) '())
      ((null? (cdr list)) (show-error "must not happen"))
      (else (cons (cons (symbol->string (car list)) (cadr list))
                  (params->alist (cddr list))))))
  (define (http url params)
    (if (null? params)
      (http-request url)
      (http-post url (params->alist params))))
  (let1 result (read-from-string (http url params))
    (if (eq? #t (car result))
      (cdr result)
      (show-error "error: got wrong response from " url))))

(define (server-ticket-list)
  (server-request "tickets/list"))

(define (server-ticket-create!)
  (server-request "tickets/create"))

(define (server-ticket-move! ticket x y)
  (server-request "tickets/move/" 'id (ticket 'id) 'x x 'y y))

(define (server-ticket-rename! ticket new-title)
  (server-request "tickets/rename" 'id (ticket 'id) 'title new-title))

(define (server-ticket-delete! ticket)
  (server-request "tickets/delete" 'id (ticket 'id)))
