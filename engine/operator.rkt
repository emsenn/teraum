#lang racket

(require uuid
         "character.rkt"
         "persistence.rkt")

(provide (all-from-out "character.rkt")
         (struct-out operator)
         make-operator
         parse-operator-line
         message-operator!
         operator-command
         set-operator-command!)

; A operator is an:
; - character
; - mudserver (mudserver)
; - in (???)
; - out (???)
; - ip (???)
; - port (???)
; - parser (procedure)
; - commands (hash-table)
(struct operator
  character
  ([mudserver]
   [in]
   [out]
   [ip]
   [port]
   [parser #:mutable]
   [commands #:mutable]))

(define (make-operator this-mudserver
                       in
                       out
                       ip
                       port
                       [parser parse-operator-line]
                       #:name [name "operator"]
                       #:description
                       [description "This is an operator."]
                       #:contents [contents '()]
                       #:world [world #f]
                       #:location [location #f]
                       #:inventory [inventory '()]
                       #:commands [commands (make-hash)])
  (operator
   (uuid-string) name description location inventory
   this-mudserver in out ip port parser commands))

; parse-arguments
;   listof string -> hash-table
; Hacky BASHy parser
(define (parse-arguments arguments)
  (define results (make-hash))
  (map
   (λ (argument)
     (cond
       [(and (> (string-length argument) 2)
             (string=? (substring argument 0 2) "--"))
        (define split-argument (string-split argument "="))
        (define argument-key (substring (car split-argument) 2))
        (define argument-value (string-join (cdr split-argument)))
        (hash-set! results argument-key argument-value)]
       [(string=? (substring argument 0 1) "-")
        (map
         (λ (character) (hash-set! results character #t))
         (string->list (substring argument 1)))]
       [else
        (hash-set!
         results 'line
         (cond
           [(hash-has-key? results 'line)
            (append (hash-ref results 'line) (list argument))]
           [else (list argument)]))]))
   arguments)
  (when (hash-has-key? results 'line)
    (hash-set! results 'line (string-join (hash-ref results 'line))))
  results)

; parse-mudsocket-operator-line
;   operator string -> void
; Handles LINE, assuming it came from OP
(define (parse-operator-line op line)
  (message-operator! op (format "Parsing ~a" line))
  (when (> (string-length line) 0)
    (define split-line (string-split line))
    (define first-word (car split-line))
    (define arguments (parse-arguments (cdr split-line)))
    (cond
      [(hash-has-key? (operator-commands op)
                      (string->symbol first-word))
       ((operator-command op (string->symbol first-word))
        arguments)]
      [else
       (message-operator! op "Invalid command.")])))

; message-operator!
;   operator string -> void
; Sends operator the string through eir operator-out.
(define (message-operator! op line)
  (with-handlers
    ([exn?
      (λ (e) (log-warning "Sending operator line failed: ~a" e))])
    (display
     (format (if (eq? #\newline (last (string->list line)))
                 "~a"
                 "~a\n")
             line)
     (operator-out op))
    (flush-output (operator-out op))))

(define (operator-command op key)
  (hash-ref (operator-commands op) key))

(define (set-operator-command! op key proc)
  (hash-set! (operator-commands op) key proc))
