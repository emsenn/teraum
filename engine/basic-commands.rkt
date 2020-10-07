#lang racket

(require "area.rkt"
         "operator.rkt")

(provide make-commands-command
         make-look-command
         make-set-name!-command)

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
               (thing-name (character-location op))
               (area-description (character-location op))
               (if (null? (hash-keys
                           (area-exits (character-location op))))
                   ""
                   (format "Exits: ~a" (hash-keys
                                        (area-exits
                                         (character-location op)))))))
      (message-operator!
       op "You aren't anyplace.")))

(define ((make-set-name!-command op) args)
  (unless (hash-has-key? args 'line)
    (message-operator! op "Syntax: set-name! <new-name>"))
  (set-character-name! op (hash-ref args 'line))
  (message-operator!
   op
   (format "Your new name is ~a" (character-name op))))
