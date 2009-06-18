(define (make-ticket id title x y)
  (define (check-title title)
    (if (string=? title "") "(no title)" title))

  (let* ((self #f)
         (id id)
         (title (check-title title))
         (x x)
         (y y)
         (div (element-new `("div.ticket" ,title))))

    (add-handler! div "click" 
                  (lambda (ev) ((self 'on-click))))
    (js-new "Draggable" div 
            'onEnd (lambda (drg) ((self 'on-drag-end))))

    (set! self
      (lambda (method . args)
        (case method
          ; properties
          ((id) id)
          ((title) title)
          ((title=) (set! title (check-title (car args))))
          ((x) x)
          ((y) y)
          ((div) div)

          ; methods
          ((on-click)
           (lambda ()
             (hand-show-ticket self)))

          ((on-drag-end)
           (lambda ()
             (call-with-values 
               (lambda () (get-position div))
               (lambda (newx newy)
                 (server-ticket-move! self
                                      (- newx (/ *width* 2))
                                      (- newy (/ *height* 2)))))))
          ; method_missing
          (else
            (show-error "unknown method:" method)))))
    self))
