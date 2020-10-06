#lang racket

(require racket/serialize
         uuid)

(provide (struct-out area)
         make-area)

(serializable-struct area
                     ([id #:mutable]
                      [name #:mutable]
                      [description #:mutable]
                      [contents #:mutable]
                      [exits #:mutable]))

(define (make-area #:name [name "area"]
                   #:description [description "This is someplace."]
                   #:contents [contents #f]
                   #:exits [exits #f]
                   #:world-directory [world-directory "../world/"])
  (define new-area
    (area (uuid-string) name description '() (make-hash)))
  (current-directory world-directory)
  (with-output-to-file (area-id new-area)
    (λ () (write (serialize new-area))))
  new-area)
