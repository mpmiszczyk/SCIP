(define (a x) (* 5 x))

(define b (* 5 5))

(define c b)


(define (sqr2 x) * x x)
;; on call (sqr 5)  return 5

(define (sqr x) (* x x))
;; proper schit

(define square
  (lambda (x)
    (* x x)))


(define (abs x)
  (cond ((< x 0) (- x))
        ((= x 0) 0)
        ((> x 0) x)))

(define (abs x)
  (if (< x 0)
      (- x)
      x))


(define (sqrt x) (try 1 x))

(define (try guess x)
  (if (good_enough guess (/ x guess))
      guess
      (try (improve guess x) x)))

(define (improve guess x)
  (average guess
           (/ x guess)))

(define (average a b)
  (/ (+ a b) 2))

(define (good_enough a b)
  (< (abs (- a b))
     0.00000004))

;; keep x in scope
(define (sqrt x)
  (define (try guess)
    (if (good_enough guess)
        guess
        (try (improve guess))))
  (define (good_enough guess)
    (< (abs (- guess (/ x guess)))
       0.00001))
  (define (improve guess)
    (average guess (/ x guess)))
  (try 1))
