#lang racket

(require qtops/qualities/area
         qtops/qualities/region
         "../../../../../../qualities/brusher.rkt")

(provide <>hargrove-street)

(define (<>redkeep t)
  (<>area t #:name "Redkeep"))

(define (<>chandlers-guild t)
  (<>area t #:name "Chandlers Guild"))

(define (<>hargrove-street-1 t)
  (<>area t #:name "Hargrove Street"))
(define (<>hargrove-street-2 t)
  (<>area t #:name "Hargrove Street"))

(define (<>hargrove-street t)
  (<>Brusher
   (<>region
    t #:name "Hargrove Street"
    #:areas `((redkeep ,<>redkeep)
              (chandlers-guild ,<>chandlers-guild)
              (hargrove-street-1 ,<>hargrove-street-1)
              (hargrove-street-2 ,<>hargrove-street-2))
    #:links '((hargrove-street-1 south north chandlers-guild)
              (hargrove-street-1 southwest northeast redkeep)
              (hargrove-street-1 southeast northwest
                                 hargrove-street-2)))))
