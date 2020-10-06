#lang racket

(require "area.rkt"
         "operator.rkt"
         "world.rkt")

(provide make-new-area!-command)

(define ((make-new-area!-command op) args)
  (unless (hash-has-key? args "exit")
    (message-operator! op "Syntax: new-area! --exit=<dir> [name]"))
  (printf "Okay so it fails to make a new area?")
  (define new-area
    (make-area (world-path (character-world op))
               #:name (if (hash-has-key? args 'line)
                          (hash-ref args 'line)
                          "new area")))
  (printf "Oh maybe it works at least this far?")
  (set-area-exit! (character-location op)
                  (hash-ref args "exit")
                  (area-id new-area))
  (set-area-exit! new-area
                  "back"
                  (area-id (character-location op)))
  (printf "All good so far")
  (save-area (character-location op)
             (world-path (character-world op)))
  (save-area new-area
             (world-path (character-world op)))
  (message-operator!
   op "Successfully made and linked new area."))
