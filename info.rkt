#lang setup/infotab
(define name "rbeta: BETA in Racket")
(define categories '(devtools))
(define can-be-loaded-with 'all)
(define required-core-version "6.9")
(define version "0.1")
(define deps '("base" "rackunit-lib"))
(define build-deps '("scribble-lib" "racket-doc"))
(define scribblings '(("scribblings/rbeta.scrbl" ())))
(define blurb
    '("BETA in Racket"))
(define release-notes
    '((p "First release")))
