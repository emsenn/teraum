#lang racket

(require racket/serialize
         "area.rkt"
         "persistence.rkt")

(provide (struct-out world)
         make-world
         load-world
         world-ref)

(serializable-struct world
                     ([areas #:mutable]
                      [path #:mutable]))

(define (make-world [path "world/"])
  (world '() path))

(define (load-world this-world)
  (current-directory (world-path this-world))
  (map
   (λ (place-id)
     (hash-set!
      (world-areas this-world)
      place-id
      (load-thing (world-path this-world) place-id)))
   (map
    (λ (dir) (path->string dir))
    (directory-list (current-directory))))
  this-world)

(define (world-ref this-world id)
  (hash-ref (world-areas this-world) id))
