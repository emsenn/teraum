#lang racket

(require qtops/qualities/area
         "../../../../../../qualities/brusher.rkt")

(provide <>gibbet-street)

(define (<>arandul-nabrish)
  (<>npc
   ;; pickpocket
   t #:name "Arandul Nabrish"))

(define (<>gibbet-street t)
  (<>Brusher
   (<>area
    t #:name "Gibbet Street"
    #:description
    "Gibbet Street is only one block, running from the Walk to the north to the Boundary, south of here. The most striking feature is its namesake gallows at the southeast corner of the block, covered in cartoonish wax masks. North of the gibbet is a two-storey brick structure with its windows and doors covered by wooden boards, with a mess of tarps and crates stacked in the field between it and the paved gallows. Across the street, is a large house, painted a variety of grays, with a wrap-around porch, and a much smaller building emitting a hot rosin smell. Between the stinky hut and mansion is a narrow alley, almost hidden by towers of folded. squashboard boxes that spill over onto the house's porch.")))
