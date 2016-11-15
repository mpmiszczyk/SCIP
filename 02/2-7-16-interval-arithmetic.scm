(load "../test-manager/load.scm")
;;;; Alyssa’s idea is to implement “interval arithmetic” as a set of
;;;; arithmetic operations for combining “intervals” (objects that
;;;; represent the range of possible values of an inexact
;;;; quantity). e result of adding,subtracting, multiplying, or
;;;; dividing two intervals is itself an interval,representing the
;;;; range of the result.


(define (make-center-width center width)
  (make-interval (- center width) (+ center width)))

(define (center-interval i)
  (/ (+ (lower-bound i)
        (upper-bound i))
     2))

(define (width-interval x)
  (/ (- (upper-bound x)
        (lower-bound x))
     2))

(define (make-center-percent center percent)
  (make-center-width center (* center percent)))

(define (percent-interval i)
  (/ (center-interval i)
     (width-interval i)))

(define (make-interval lower upper)
  (cons lower upper))

(define lower-bound car)

(define upper-bound cdr)

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (sub-interval x y)
  (make-interval (- (lower-bound x) (upper-bound y))
                 (- (upper-bound x) (lower-bound y))))

;; (= ((- 2 2) . (- 3 1))
;;    (sub-interval (2 . 3)
;;                  (1 . 2)))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (upper-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (lower-bound x) (upper-bound y))))
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

(define (spans-over-zero? i)
  (not (eq? (positive? (lower-bound i))
            (positive? (upper-bound i)))))

;; 2.14
(define (par1 a b)
  (div-interval (mul-interval a b)
                (add-interval a b)))

(define (par2 a b)
  (let ((one (make-interval 1 1)))
    (div-interval one
                  (add-interval (div-interval one a)
                                (div-interval one b)))))

(define (compare-two-a)
  (compare-two 100 0.01))

(define (compare-two center-range percente-range)
  (let ((a (make-center-percent (random center-range)
                                (random percente-range)))
        (b (make-center-percent (random center-range)
                                (random percente-range))))
    (sub-interval (par1 a b)
                  (par2 a b))))



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
