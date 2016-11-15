(load "../test-manager/load.scm")
;;;; Alyssa’s idea is to implement “interval arithmetic” as a set of
;;;; arithmetic operations for combining “intervals” (objects that
;;;; represent the range of possible values of an inexact
;;;; quantity). e result of adding,subtracting, multiplying, or
;;;; dividing two intervals is itself an interval,representing the
;;;; range of the result.


(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))


(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (upper-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (lower-bound x) (upper-bound y)0)))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (mul-interval x
                (make-interval (/ 1 (upper-bound y))
                               (/ 1 (lower-bound y)))))


(run-registered-tests)
