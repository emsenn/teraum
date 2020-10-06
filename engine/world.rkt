#lang racket

(require racket/serialize
         "area.rkt")

(provide (struct-out world)
         make-world
         load-world
         world-ref)

(serializable-struct world
                     ([areas #:mutable]
                      [path #:mutable]))
(define (make-world [path "world/"])
  (world (make-hash) path))

(define (load-world this-world)
  (current-directory (world-path this-world))
  (map
   (λ (area-file)
     (with-input-from-file area-file
       (λ ()
         (hash-set!
          (world-areas this-world)
          (string->symbol area-file)
          (deserialize (read))))))
   (map
    (λ (dir)
      (path->string dir))
    (directory-list (current-directory))))
  this-world)

(define (world-ref this-world id)
  (hash-ref (world-areas this-world) id))
