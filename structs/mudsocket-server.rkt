#lang racket

(require "mudsocket-operator.rkt")

; A mudsocket-server is a
; - tcp-listener (object? i think)
; - active-operators (listof mudsocket-operator)
; - tick (integer)
; - clock (thread)
(struct mudsocket-server
  ([tcp-listener]
   [active-operators #:mutable]
   [tick #:mutable]
   [clock #:mutable]))

; make-mudsocket-server
;   [int] -> mudsocket-server
(define (make-mudsocket-server #:port [port 4242])
  (mudsocket-server
   (tcp-listen port 5 #t)
   '()
   0
   (void)))

; accept-mudsocket-server-operator
;   mudsocket-server -> void
; Creates a new mudsocket-operator for the new connection
; on SERVER's tcp-listener.
(define (accept-mudsocket-server-operator server)
  (define-values
    (in out)
    (tcp-accept (mudsocket-server-tcp-listener server)))
  (define-values
    (local-ip local-port remote-ip remote-port)
    (tcp-addresses in #t))
  (define connected-operator
    (mudsocket-operator
     "new operator"
     ""
     in
     out
     remote-ip
     remote-port))
  (set-mudsocket-server-active-operators!
   server
   (append (mudsocket-server-active-operators server)
           (list connected-operator)))
  (set-operator-output-buffer!
   connected-operator
   "Your connection to the MUDSocket server has been accepted."))

; parse-mudsocket-operator-line
;   mudsocket-operator string -> void
; Handles LINE, assuming it came from OP
(define (parse-mudsocket-operator-line op line)
  (set-operator-output-buffer!
   op
   (format "Your line was: ~a" line)))

; send-mudsocket-operator-output-buffer
;   mudsocket-operator -> void
; Sends OP eir operator output-buffer, through their
; mudsocket-operator out.
(define (send-mudsocket-operator-output-buffer op)
  (with-handlers
    ([exn?
      (λ (e)
        (log-warning "Sending operator output-buffer failed: ~a"
                     e))])
    (display
     (format
      (if (eq? #\newline
               (last (string->list
                      (operator-output-buffer op))))
          "~a"
          "~a\n")
      (operator-output-buffer op))
     (mudsocket-operator-out op))
    (flush-output (mudsocket-operator-out op))
    (set-operator-output-buffer! op "")))

(define (remove-mudsocket-server-operator server op)
  (set-mudsocket-server-active-operators!
   server
   (remove op (mudsocket-server-active-operators server)))
  (close-input-port (mudsocket-operator-in op))
  (close-output-port (mudsocket-operator-out op)))

(define (handle-mudsocket-server-operators server)
  (map
   (λ (op)
     (cond
       [(port-closed? (mudsocket-operator-in op))
        (remove-mudsocket-server-operator server op)]
       [(byte-ready? (mudsocket-operator-in op))
        (with-handlers
          ([exn:fail?
            (λ (e)
              (log-warning "MUDSocket server encountered issue: ~a"
                           e))])
          (define op-line
            (read-line (mudsocket-operator-in op)))
          (cond
            [(string? op-line)
             (parse-mudsocket-operator-line op
                                            op-line)]
            [(eof-object? op-line)
             (remove-mudsocket-server-operator server
                                                 op)]))])
     (when (> (string-length
               (operator-output-buffer op))
              0)
       (send-mudsocket-operator-output-buffer op)))
   (mudsocket-server-active-operators server))
  (when (tcp-accept-ready? (mudsocket-server-tcp-listener server))
    (accept-mudsocket-server-operator server)))

; start-mudsocket-server: mudsocket-server -> thread
; Takes a MUDSocket server and returns a thread looping over
; handle-mudsocket-server-operators every CLOCK-SPEED seconds.
(define (start-mudsocket-server! server [clock-speed 0.2])
  (set-mudsocket-server-clock!
   server
   (thread
    (λ ()
      (let mudsocket-server-loop ()
        (handle-mudsocket-server-operators server)
        (set-mudsocket-server-tick!
         server
         (+ 1 (mudsocket-server-tick server)))
        (sleep clock-speed)
        (mudsocket-server-loop)))))
  (mudsocket-server-clock server))

(define a-mud (start-mudsocket-server! (make-mudsocket-server)
                                       2))
