#lang racket

(require racket/serialize)

(provide (struct-out thing)
         make-thing)

(serializable-struct thing
                     ([id #:mutable]
                      [name #:mutable]))

(define (make-thing #:name [name "thing"])
  (thing 0 name))
