#lang racket

(require qtops/qualities/area
         qtops/qualities/region
         "../../../../../qualities/brusher.rkt")

(provide <>vickers-street)

(define (<>vickers-street-1 t)
  (<>area t #:name "Vickers Street"))
(define (<>vickers-street-2 t)
  (<>area t #:name "Vickers Street"))




(define (<>vickers-street t)
  (<>Brusher
   (<>region
    t #:name "Vickers Street"
    #:areas `((vickers-street-1 ,<>vickers-street-1)
              (vickers-street-2 ,<>vickers-street-2))
    #:links '((vickers-street-1 south north vickers-street-2)))))