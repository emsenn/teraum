#lang racket

(require qtops/qualities/area
         qtops/qualities/region
         "../../../../../../qualities/brusher.rkt")

(provide <>arathel-street)

(define (<>arathel-street-1 t)
  (<>area t #:name "north"))

(define (<>arathel-street-2 t)
  (<>area t #:name "south"))


(define (<>arathel-street t)
  (<>Brusher
   (<>region
    t #:name "Arathel Street"
    #:areas `((arathel-street-1 ,<>arathel-street-1)
              (arathel-street-2 ,<>arathel-street-2)))))
