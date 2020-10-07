#lang racket

(require racket/serialize)

(provide (struct-out thing)
         make-thing
         find-thing)

(serializable-struct thing
                     ([id #:mutable]
                      [name #:mutable]))

(define (make-thing #:name [name "thing"])
  (thing 0 name))

(define (find-thing given-list given-id)
  (printf "Looking at list ~a"
          (map
           (λ (q) (thing-id q))
           given-list))
   (findf
    (λ (q)
      (printf "Looking at ~a" (thing-id q))
      (string=? (thing-id q) given-id))
    given-list))
