#lang racket

(require qtops/qualities/area
         qtops/qualities/npc
         qtops/qualities/region
         "../../../../../qualities/brusher.rkt"
         "gibbet-street/main.rkt")

(provide <>bellybrush)

(define (<>wadren-smith t)
  ;; not friendly with Holman Holder
  ;; used to live in Southbank House prior to winter 80pc, got evicted by Red Union
  ;; they stole his pigs
  (<>npc
   t #:name "Wadren Smith"))

(define (<>holman-holder t)
  ;; used to steal wadren smith's pigs, when wadren lived in the Southbank House
  (<>npc
   t #:name "Holman Holder"))

(define (<>arathel-road t) (<>area t #:name "Arathel Road"))
(define (<>east-harbrook-street t)
  (<>area t #:name "East Harbrook Street"))
(define (<>east-kingsroad t)
  (<>area t #:name "East Kingsroad"))
(define (<>kingsroad-outside-orphanage t)
  (<>area t #:name "Kingsroad, outside orphanage"
         #:description "Mother Jaffa's orphanage and laundromat is here."))
(define (<>west-harbrook-street t)
  (<>area t #:name "West Harbrook Street"))
(define (<>west-kingsroad t) (<>area t #:name "West Kingsroad"))
(define (<>westgate t)
  (<>area t #:name "Westgate"
          #:description "This is the road by and under Westgate, a limestone folly."))


(define (<>bellybrush t)
  (<>Brusher
   (<>region
    t #:name "Bellybrush"
    #:areas `((arathel-road ,<>arathel-road)
              (east-harbrook-street ,<>east-harbrook-street)
              (east-kingsroad ,<>east-kingsroad)
              (gibbet-street ,<>gibbet-street)
              (kingsroad-outside-orphanage
               ,<>kingsroad-outside-orphanage)
              (west-harbrook-street ,<>west-harbrook-street)
              (west-kingsroad ,<>west-kingsroad)
              (westgate ,<>westgate))
    #:links '((arathel-road east west east-harbrook-street)
              ;; cities are so confusing, irl too
              (arathel-road west east west-harbrook-street)
              (east-harbrook-street south north east-kingsroad)
              (east-kingsroad west east kingsroad-outside-orphanage)
              (kingsroad-outside-orphanage
               west east
               west-kingsroad)
              (west-harbrook-street
               south north
               westgate)
              (west-kingsroad
               north south
               westgate)))
    #:trivia '("The town of Bellybrush was settled in 701bB")))
