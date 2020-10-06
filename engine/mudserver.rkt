#lang racket

(require "area.rkt"
         "basic-commands.rkt"
         "creator-commands.rkt"
         "operator.rkt"
         "world.rkt")

(provide (struct-out mudserver)
         make-mudserver
         start-mudserver!)

; A mudserver is a
; - tcp-listener (object? i think)
; - active-operators (listof mudsocket-operator)
; - tick (integer)
; - clock (thread)
(struct mudserver
  ([tcp-listener]
   [active-operators #:mutable]
   [world #:mutable]
   [tick #:mutable]
   [clock #:mutable]))

; make-mudserver
;   [int] -> mudserver
(define (make-mudserver world #:port [port 4242])
  (mudserver (tcp-listen port 5 #t) '() world 0 (void)))

; accept-mudserver-operator
;   mudserver -> void
; Creates a new mudsocket-operator for the new connection
; on SERVER's tcp-listener.
(define (accept-mudserver-operator server)
  (define-values
    (in out)
    (tcp-accept (mudserver-tcp-listener server)))
  (define-values
    (local-ip local-port remote-ip remote-port)
    (tcp-addresses in #t))
  (define op
    (make-operator server in out remote-ip remote-port
                   #:world (mudserver-world server)))
  (set-operator-command! op 'commands (make-commands-command op))
  (set-operator-command! op 'look (make-look-command op))
  (set-operator-command! op 'set-name! (make-set-name!-command op))
  (set-operator-command! op 'who (make-who-command op))
  (set-mudserver-active-operators!
   server
   (append (mudserver-active-operators server)
           (list op)))
  (message-operator!
   op
   (format
    "Your connection to Teraum from ~a has been accepted."
    (format "~a:~a" (operator-ip op) (operator-port op))))
  (when (string=? (operator-ip op) "::1")
    (message-operator!
     op "(Welcome to Teraum, creator.)")
    (set-operator-command! op 'new-area!
                           (make-new-area!-command op))
    (set-operator-command! op 'set-area-name!
                           (make-set-area-name!-command op))
    (set-operator-command! op 'set-area-description
                           (make-set-area-description!-command op)))
  (let ([spawn (world-ref (mudserver-world server)
                          '15fd6ad9-0632-4212-8c6b-968d0ff04e30)])
    (set-character-location! op spawn)
    (add-thing-to-area! op spawn)))


(define (remove-mudserver-operator server op)
  (set-mudserver-active-operators!
   server
   (remove op (mudserver-active-operators server)))
  (close-input-port (operator-in op))
  (close-output-port (operator-out op)))

(define (handle-mudserver-operators server)
  (map
   (λ (op)
     (cond
       [(port-closed? (operator-in op))
        (remove-mudserver-operator server op)]
       [(byte-ready? (operator-in op))
        (with-handlers
          ([exn:fail?
            (λ (e)
              (log-warning "MUDSocket server encountered issue: ~a"
                           e))])
          (define op-line
            (read-line (operator-in op)))
          (cond
            [(string? op-line)
             (parse-operator-line op op-line)]
            [(eof-object? op-line)
             (remove-mudserver-operator server op)]))]))
   (mudserver-active-operators server))
  (when (tcp-accept-ready? (mudserver-tcp-listener server))
    (accept-mudserver-operator server)))

; start-mudserver: mudserver -> thread
; Takes a MUDSocket server and returns a thread looping over
; handle-mudserver-operators every CLOCK-SPEED seconds.
(define (start-mudserver! server [clock-speed 0.2])
  (set-mudserver-clock!
   server
   (thread
    (λ ()
      (let mudserver-loop ()
        (handle-mudserver-operators server)
        (set-mudserver-tick! server (+ 1 (mudserver-tick server)))
        (sleep clock-speed)
        (mudserver-loop)))))
  (mudserver-clock server))


(define ((make-who-command op) args)
  (message-operator!
   op (format "~a"
              (map
               (λ (o) (character-name o))
               (mudserver-active-operators
                (operator-mudserver op))))))
