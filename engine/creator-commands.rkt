#lang racket

(require "area.rkt"
         "operator.rkt"
         "world.rkt")

(provide make-new-area!-command
         make-set-area-name!-command)

(define ((make-set-area-name!-command op) args)
  (unless (hash-has-key? args 'line)
    (message-operator! op "Syntax: set-area-name! <new-name>"))
  (set-area-name! (character-location op)
                  (hash-ref args 'line))
  (save-area (character-location op)
             (world-path (character-world op))))

(define ((make-new-area!-command op) args)
  (unless (hash-has-key? args "exit")
    (message-operator! op "Syntax: new-area! --exit=<dir> [name]"))
  (define new-area
    (make-area (world-path (character-world op))
               #:name (if (hash-has-key? args 'line)
                          (hash-ref args 'line)
                          "new area")))
  (set-area-exit! (character-location op)
                  (hash-ref args "exit")
                  (area-id new-area))
  (set-area-exit! new-area
                  "back"
                  (area-id (character-location op)))
  (save-area (character-location op)
             (world-path (character-world op)))
  (save-area new-area
             (world-path (character-world op)))
  (message-operator!
   op "Successfully made and linked new area."))
