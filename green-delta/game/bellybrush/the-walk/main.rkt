#lang racket

(require qtops/qualities/area
         qtops/qualities/region)

(provide <>the-walk)

(define (<>the-walk t)
  (<>Brusher
   (<>region t #:name "The Walk")))
