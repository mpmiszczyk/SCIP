(load "../test-manager/load.scm")

(define (accumulate fun initial-value sequance)
  (if (null? sequance)
      initial-value
      (fun (car sequance)
           (accumulate fun initial-value (cdr sequance)))))      ;

(define (horner-eval x coefficient-sequence)
  (accumulate (lambda (this-coeff higher-terms)
                (+ (* higher-terms x)
                   this-coeff))
              0
              coefficient-sequence))

(define-test (simple-exmaples)
  (check (equal? (horner-eval 0 (list 1 2 3 4))
                 1)) ; only a0
  (check (equal? (horner-eval 1 (list 1 2 3 4))
                 (+ 1 2 3 4))) ; each x^n will be equal 1
  (let ((r (random 100)))
    (check (equal? (horner-eval r (list 1 5))
                   (+ 1 (* 5 r))))))

(run-registered-tests)
