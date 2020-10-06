#lang racket

(require "engine/mudserver.rkt"
         "engine/world.rkt")

(define teraum (make-mudserver
                #:world (load-world "world/")))

(start-mudserver! teraum 0.2)
