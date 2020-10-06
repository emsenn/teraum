#lang racket

(require "engine/mudserver.rkt")

(define teraum
  (start-mudserver!
   (make-mudserver)
   0.2))
