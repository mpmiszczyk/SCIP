(define (average-damp f)
  (lambda (x) (average x (f x))))

(define (cube x)
  (* x x x))

(define average-dump-cube
  (average-dump cube))

(define (sqrt x)
  (fixed-point (average-damp (lambda (y) (/ x (square y))))
               1.))

;; or the other way
(define (average-damp f x)
  (average x (f x)))

(define (cube x)
  (* x x x))

(define (average-dump-cube x)
  (average-dump cube x))

(define (sqrt x)
  (fixed-point ((lambda (y)
                  (average-damp (lambda (z)
                                  (/ x (square z)))
                                y))
                1.)))

;; which is baisicaly same thing
;;
;; Only differences that come to mind, are
;;
;;  - second will change with `cube` being redefined (in global
;;  context, of course it will not be shadowed). I think I would
;;  prefere the second approach, but this easilly could be argued
;;
;;  - both could be used only with one argument, but if you do
;;  otherwise, you will find out in different moments.  In first case
;;  during usage of the function, in second already during definition.
;;  First case seems to be prefered.  And if you would like to check
;;  how many arguments `average-dump-cube` will take, in first case
;;  you will have to do little more searching.
;;
;;  - like mentioned in some notes, the second one could be used only
;;  for definitions, the first ogne in all the places where you would
;;  like to pass aroung `lambda`
