#lang typed/racket

(provide pattern
         (rename-out
           [Pattern? pattern?]))

(require racket/stxparam)
(require (for-syntax syntax/parse))

(define-type BindingType (U 'pattern
                            'object
                            'reference
                            'pattern-reference))

(struct Binding ([name   : Symbol]
                 [type   : BindingType]
                 [final? : Boolean]
                 [rhs    : Pattern]))

(struct Pattern ([parent : (U Pattern #false)]
                 [fields : (Listof Binding)]
                 [enter  : (Listof Symbol)]
                 [exit   : (Listof Symbol)]
                 [action : (-> (-> Void) Void)]))

(define-syntax-parameter inner
  (λ (stx)
     (raise-syntax-error #f "use of inner not in an action" stx)))

(define-syntax (pattern stx)
  (syntax-parse stx
    [(_ #:super parent:expr
        ([name:id rhs:expr] ...)
        #:enter (x:id ...)
        #:exit (y:id ...)
        action:expr ...)
     #'(Pattern parent
                (list (Binding name 'pattern #true rhs) ...)
                (list 'x ...)
                (list 'y ...)
                (lambda ([inner-f : (-> Void)])
                  (syntax-parameterize
                    ([inner (syntax-rules () [(_) (inner-f)])])
                    action ...
                    (void))))]))

; A Pattern-object is
;   (make-pattern-object [Hashtbl-of Symbol Pattern-object]
;                        [Any ... ->]
;                        [-> Any ...]
;                        [->])
; (define-struct pattern-object
  ; (fields enter exit action))
