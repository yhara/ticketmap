(define *hand-ticket* #f)

(define (hand-show-ticket ticket)
  (when (not (eq? ticket *hand-ticket*))
    (set! *hand-ticket* ticket)
    (set-content! ($ "hand_title") (ticket 'title))
    (element-hide! ($ "hand_title_submit"))
    (set-content! ($ "hand_desc")
                  (string-append "(" 
                                 (get-style (ticket 'div) "left")
                                 ","
                                 (get-style (ticket 'div) "top")
                                 ")"))))

(define-macro (with-button-toggle button . body)
  `(unless (element-visible? ,button)
     (element-show! ,button)
     ,@body
     (element-hide! ,button)))

(define (hand-on-title-clicked)
  (define (make-rename-form old)
    (string-append "<input type='text' value='" old "' id='rename_text'>"))

  (let1 ok-button ($ "hand_title_submit")
    (with-button-toggle ok-button
      (element-update! ($ "hand_title") 
                       (make-rename-form (get-content ($ "hand_title"))))
      (js-invoke ($ "rename_text") "focus")

      (wait-for ok-button "click")

      (let1 new-title (get-content ($ "rename_text"))
        (*hand-ticket* 'title= new-title)
        (element-update! ($ "hand_title") new-title)
        (element-update! (*hand-ticket* 'div) new-title)
        (server-ticket-rename! *hand-ticket* new-title)))))

(define (hand-on-delete-clicked)
  (when *hand-ticket*
    (when (confirm (string-append "really delete '"
                                  (*hand-ticket* 'title)
                                  "' ?"))
      (server-ticket-delete! *hand-ticket*)
      (element-remove! (*hand-ticket* 'div))
      (set! *hand-ticket* #f)
      (element-clear! ($ "hand_title"))
      (element-clear! ($ "hand_desc")))))
