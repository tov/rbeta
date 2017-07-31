#lang racket

(provide pattern?)

(define-struct pattern
  (fields enter exit action))
