#lang racket

Budlock, Ishbone, Rarad, Fit, and Lara.

(define (<>budlock t)
  (<>npc t #:name "Budlock"))
(define (<>ishbone t)
  (<>npc t #:name "Ishbone"))
(define (<>fit t)
  (<>npc t #:name "Fit"))
(define (<>rarad t)
  (<>npc t #:name "Rarad"))
(define (<>lara t)
  (<>npc t #:name "Lara"))

(define (<>beggars-alley t)
  (<>area
   t #:name "Beggar's Alley"
   #:description "This is Beggar's Alley. Once the lawns shared by luxury estates, the area was taken over decades ago by locals and has become the permanent home of many of the town's poorest residents."
   #:contents (list <>budlock <>ishbone <>fit <>rarad <>lara)))
