#lang racket

(require racket/serialize)

(provide (struct-out operator))

; An operator is a
; - name (string)
; - output-buffer (string)
(serializable-struct
  operator
  ([name #:mutable]
   [output-buffer #:mutable]))
