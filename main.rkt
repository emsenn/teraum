#lang racket

(require "engine/mudserver-struct.rkt"
         "engine/mudserver.rkt"
         "engine/persistence.rkt")

(define teraum (make-mudserver
                (load-things "/home/emsenn/dev/teraum/world/")
                (load-things "/home/emsenn/dev/teraum/operators/")))

(start-mudserver! teraum 0.2)
