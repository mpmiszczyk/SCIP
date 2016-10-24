(load "../test-manager/load.scm")


(define (pascal row column)
  (cond ((and (= row 1) (= column 1)) 1)
        ((not (<= 1 column row)) 0)
        (else (+ (pascal (- row 1) column)
                 (pascal (- row 1) (- column 1)))))
  )





(define (pascal-check row column value)
  "test helper"
  (check (= (pascal row column)
            value)))

(define-test (first-line)
  (pascal-check 1 1
                1))

(define-test (second-line)
  (pascal-check 2 1
                1)
  (pascal-check 2 2
                1)
  (pascal-check 2 3
                0))

(define-test (third-line)
  (pascal-check 3 1
                1)
  (pascal-check 3 2
                2))

(define-test (greater-value)
  (pascal-check 5 3
                6))


(run-registered-tests)
