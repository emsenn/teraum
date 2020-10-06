#lang racket

(require racket/serialize
         "area.rkt")

(provide load-world
         world-ref)

(define (load-world [world-directory "../world/"])
  (current-directory world-directory)
  (define areas (make-hash))
  (map
   (λ (area-file)
     (with-input-from-file area-file
       (λ ()
         (hash-set!
          areas
          (string->symbol area-file)
          (deserialize (read))))))
   (map
    (λ (dir)
      (path->string dir))
    (directory-list (current-directory))))
  areas)

(define (world-ref world id)
  (hash-ref world id))
