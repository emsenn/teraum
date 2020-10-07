#lang racket

(provide (struct-out mudserver)
         make-mudserver)

; A mudserver is a
; - tcp-listener (object? i think)
; - active-operators (listof mudsocket-operator)
; - tick (integer)
; - clock (thread)
(struct mudserver
  ([tcp-listener]
   [known-operators #:mutable]
   [active-operators #:mutable]
   [world #:mutable]
   [tick #:mutable]
   [clock #:mutable]))

; make-mudserver
;   [int] -> mudserver
(define (make-mudserver world operators #:port [port 4242])
  (mudserver (tcp-listen port 5 #t) operators '() world 0 (void)))
