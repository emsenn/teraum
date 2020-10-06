#lang racket

(require racket/serialize
         uuid)


(provide (struct-out character))

(serializable-struct character
                     ([id #:mutable]
                      [name #:mutable]
                      [description #:mutable]
                      [world #:mutable]
                      [location #:mutable]
                      [inventory #:mutable]))

(define (make-character #:name [name "character"]
                        #:description [description "This is someone."]
                        #:contents [contents '()]
                        #:world [world #f]
                        #:location [location #f]
                        #:inventory [inventory '()])
  (character (uuid-string)
             name
             description
             world
             location
             inventory))
