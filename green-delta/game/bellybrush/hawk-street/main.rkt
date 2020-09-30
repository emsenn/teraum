#lang racket

(require qtops/qualities/area
         qtops/qualities/region
         "../../../../../../qualities/brusher.rkt")

(provide <>hawk-street)

(define (<>cheers t)
  (<>area t #:name "Cheers"))
(define (<>asylum t)
  (<>area t #:name "Asylum"))
(define (<>undertaker t)
  (<>area t #:name "Undertaker"))
(define (<>thrift-shop t)
  (<>area t #:name "thrift shop"))

(define (<>hawk-street-1 t)
  (<>area t #:name "Hawk Street"))
(define (<>hawk-street-2 t)
  (<>area t #:name "Hawk Street"))
(define (<>hawk-street-3 t)
  (<>area t #:name "Hawk Street"))
(define (<>hawk-street-4 t)
  (<>area t #:name "Hawk Street"))

(define (<>hawk-street t)
  (<>Brusher
   (<>region
    t #:name "Hawk Street"
    #:areas `((cheers ,<>cheers)
              (asylum ,<>asylum)
              (undertaker ,<>undertaker)
              (thrift-shop ,<>thrift-shop)
              (hawk-street-1 ,<>hawk-street-1)
              (hawk-street-2 ,<>hawk-street-2)
              (hawk-street-3 ,<>hawk-street-3)
              (hawk-street-4 ,<>hawk-street-4))
    #:links '((hawk-street-3 southeast northwest asylum)
              (hawk-street-3 southwest northeast undertaker)
              (hawk-street-3 west east cheers)
              (hawk-street-4 west east thrift-shop)
              (hawk-street-1 south north hawk-street-2)
              (hawk-street-2 south north hawk-street-3)
              (hawk-street-3 south north hawk-street-4)))))
