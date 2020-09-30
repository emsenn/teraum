#lang racket

(require qtops/qualities/area
         qtops/qualities/region
         "../../../../../../qualities/brusher.rkt")

(provide <>the-walk)

(define (<>fletchers t)
  (<>area t #:name "Fletchers"))

(define (<>the-walk-1 t)
  (<>area t #:name "The Walk"))
(define (<>the-walk-2 t)
  (<>area t #:name "The Walk"))

(define (<>the-walk-3 t)
  (<>area t #:name "The Walk"))
(define (<>the-walk-4 t)
  (<>area t #:name "The Walk"))



(define (<>the-walk t)
  (<>Brusher
   (<>region
    t #:name "The Walk"
    #:areas `((the-walk-1 ,<>the-walk-1)
              (the-walk-2 ,<>the-walk-2)
              (the-walk-3 ,<>the-walk-3)
              (the-walk-4 ,<>the-walk-4))
    #:links '((the-walk-1 east west the-walk-2)
              (the-walk-2 east west the-walk-3)
              (the-walk-3 east west the-walk-4)))))
