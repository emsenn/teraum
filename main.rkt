#lang racket

(require "engine/mudserver.rkt"
         "engine/mudserver-struct.rkt"
         "engine/world.rkt")

(define teraum (make-mudserver
                (load-world
                 (make-world "/home/emsenn/dev/teraum/world/"))))

(start-mudserver! teraum 0.2)
