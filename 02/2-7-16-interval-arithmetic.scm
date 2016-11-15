(load "../test-manager/load.scm")
;;;; Alyssa’s idea is to implement “interval arithmetic” as a set of
;;;; arithmetic operations for combining “intervals” (objects that
;;;; represent the range of possible values of an inexact
;;;; quantity). e result of adding,subtracting, multiplying, or
;;;; dividing two intervals is itself an interval,representing the
;;;; range of the result.


(define (make-interval lower upper)
  (cons lower upper))

(define lower-bound car)

(define upper-bound cdr)

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (sub-interval x y)
  (make-inteval (- (lower-bound x) (upper-bound y))
                (- (upper-bound x) (lower-bound y))))

;; (= ((- 2 2) . (- 3 1))
;;    (sub-interval (2 . 3)
;;                  (1 . 2)))

(define (width-interval x)
  (- (upper-bound x) (lower-bound x)))

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

;; 2.10 will raise
(define (div-interval x y)
  (if (not (spans-over-zero? y))
      (mul-interval x
                    (make-interval (/ 1 (upper-bound y))
                                   (/ 1 (lower-bound y))))
      (error "division over zero not allowed" y)))


;; 2.9 in some way it is a funciton, but not a monotonic one

(define-test (same-width-from-different-widths)
  (let ((a (make-interval 0 2))
        (b (make-interval 2 2))
        (c (make-interval 0 2)))
    (check (not (= (width-interval b)
                   (width-interval c))))
    (check (= (width-interval (mul-interval a b))
              (width-interval (mul-interval a c))))))


(run-registered-tests)
