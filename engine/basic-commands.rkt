#lang racket

(require "area.rkt"
         "operator.rkt")

(provide make-commands-command
         make-look-command)

(define ((make-commands-command op) args)
  (message-operator!
   op
   (format "~a" (hash-keys (operator-commands op)))))

(define ((make-look-command op) args)
  (message-operator! op (format "Trying to look at ~a"
                                (character-location op)))
  (if (character-location op)
      (message-operator!
       op
       (format "[  ~a  ]\n~a~a"
               (area-name (character-location op))
               (area-description (character-location op))
               (if (null? (hash-keys
                           (area-exits (character-location op))))
                   ""
                   (format "Exits: ~a" (hash-keys
                                        (area-exits
                                         (character-location op)))))))
      (message-operator!
       op "You aren't anyplace.")))
