(load "../test-manager/load.scm")

(define (exp a n)
  (define (iter base exponent)
    (cond ((= exponent 0) 1)
          ((even? exponent) (iter (* base base) (/ exponent 2)))
          (else (iter (* a base) (- exponent 1)))))
  (iter a n))




(define-test (simple)
  (check (= (exp 2 3)
            8))
  (check (= (exp 8 1)
            8))
  (check (= (exp 5 0)
            1))
  )

(run-registered-tests)
