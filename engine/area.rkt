#lang racket

(require racket/serialize
         uuid)

(provide (struct-out area)
         make-area
         save-area
         area-exit
         set-area-exit!
         add-thing-to-area!)

(serializable-struct area
                     ([id #:mutable]
                      [name #:mutable]
                      [description #:mutable]
                      [contents #:mutable]
                      [exits #:mutable]))

(define (make-area world-path
                   #:name [name "area"]
                   #:description [description "This is someplace."]
                   #:contents [contents #f]
                   #:exits [exits #f])
  (define new-area
    (area (uuid-string) name description '() (make-hash)))
  (printf "Made new area named ~a" (area-name new-area))
  (save-area new-area world-path)
  new-area)

(define (save-area this-area world-path)
  (current-directory world-path)
  (printf "Current directory is ~a" (current-directory))
  (with-output-to-file (area-id this-area)
    (λ () (write (serialize this-area)))
    #:exists 'replace))

(define (area-exit this-area exit-key)
  (hash-ref (area-exits this-area) exit-key))

(define (set-area-exit! this-area exit-key exit-value)
  (hash-set! (area-exits this-area) exit-key exit-value))

(define (add-thing-to-area! new-thing this-area)
  (set-area-contents! this-area
                      (append (area-contents this-area)
                              (list new-thing))))
