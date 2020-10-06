#lang racket

(require racket/serialize
         uuid)


(provide (struct-out character))

(serializable-struct character
                     ([id #:mutable]
                      [name #:mutable]
                      [description #:mutable]
                      [location #:mutable]
                      [inventory #:mutable]))

(define (make-character #:name [name "character"]
                        #:description [description "This is someone."]
                        #:contents [contents '()]
                        #:location [location #f]
                        #:inventory [inventory '()])
  (character (uuid-string)
             name
             description
             location
             inventory))
