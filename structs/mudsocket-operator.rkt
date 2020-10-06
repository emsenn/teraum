#lang racket

(require "operator.rkt")

(provide (all-from-out "operator.rkt")
         (struct-out mudsocket-operator))

; A mudsocket-operator is an:
; - operator (structure)
; - in (???)
; - out (???)
; - ip (???)
; - port (???)
(struct mudsocket-operator
  operator
  ([in]
   [out]
   [ip]
   [port]))
