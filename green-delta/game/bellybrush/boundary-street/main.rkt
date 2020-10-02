#lang racket

(require qtops/qualities/area
         qtops/qualities/region
         "../../../../../../qualities/brusher.rkt")

(provide <>boundary-street)

(define (<>leaping-eel t)
  (<>area
   t #:name "Leaping Eel"
   #:description "The Leaping Eel was once the tavern travelers thought of when they remembered Bellybrush. Located where the Kingsroad intersects Arathel Street, almost every person moving through the Green Delta would walk by the Leaping Eel. Now that Bellybrush has been incorporated into the GAME, the Eel has leaned into its \"townie\" roots, proudly demonstrating its status as the owner of The Brushers, the local stick-ball team. Flags, the dusty orange and cream white colors of the team, cover nearly every wall in their horizontal stripes, with pieces of sports equipment nailed between them. Booths line the bottom of each wall, patrons and waitstaff milling about."))
(define (<>hamaking-warehouse t)
  (<>area
   t #:name "Hamaking Warehouse"
   #:description "This is Hamaking Warehouse, a large brick structure full of shelves, crates, boxes, and other means of storing stuff."))
(define (<>central-park-1 t)
  (<>area
   t #:name "Central Park"
   #:description "This is the west side of Bellybrush's Central Park. The area is mostly just a grass field, with a very large old stump near the center."))
(define (<>central-park-2 t)
  (<>area
   t #:name "Central Park"
   #:description "This is the east side of Bellybrush's Central Park."))
(define (<>westmeet t)
  (<>area t #:name "Westmeet"))
(define (<>island t)
  (<>area t #:name "Island"))

(define (<>boundary-street-1 t)
  (<>area t #:name "Boundary Street"))
(define (<>boundary-street-2 t)
  (<>area t #:name "Boundary Street"))
(define (<>boundary-street-3 t)
  (<>area t #:name "Boundary Street"))
(define (<>boundary-street-4 t)
  (<>area t #:name "Boundary Street"))
(define (<>boundary-street-5 t)
  (<>area t #:name "Boundary Street"))
(define (<>boundary-street-6 t)
  (<>area t #:name "Boundary Street"))

(define (<>boundary-street t)
  (<>Brusher
   (<>region
    t #:name "Boundary Street"
    #:areas `((leaping-eel ,<>leaping-eel)
              (hamaking-warehouse ,<>hamaking-warehouse)
              (westmeet ,<>westmeet)
              (central-park-1 ,<>central-park-1)
              (central-park-2 ,<>central-park-2)
              (island ,<>island)
              (boundary-street-1 ,<>boundary-street-1)
              (boundary-street-2 ,<>boundary-street-2)
              (boundary-street-3 ,<>boundary-street-3)
              (boundary-street-4 ,<>boundary-street-4)
              (boundary-street-5 ,<>boundary-street-5)
              (boundary-street-6 ,<>boundary-street-6))
    #:links '((boundary-street-1 north south leaping-eel)
              (boundary-street-1 southeast northwest central-park-1)
              (boundary-street-1 south north hamaking-warehouse)
              (boundary-street-2 northeast southwest westmeet)
              (boundary-street-2 southeast northwest central-park-2)
              (boundary-street-2 south north central-park-1)
              (boundary-street-3 north south westmeet)
              (boundary-street-3 south north central-park-2)
              (boundary-street-3 southwest northeast central-park-1)
              (boundary-street-6 northeast southwest island)
              (boundary-street-1 east west boundary-street-2)
              (boundary-street-2 east west boundary-street-3)
              (boundary-street-3 east west boundary-street-4)
              (boundary-street-4 east west boundary-street-5)
              (boundary-street-5 southeast northwest
                                 boundary-street-6)))
   #:trivia '("Before the Walk was built, Boundary Street was Bellybrush's original riverfront.")))
