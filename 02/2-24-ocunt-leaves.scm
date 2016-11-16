(load "../test-manager/load.scm")

(define (count-leaves tree)
  (define (node? x) (not (pair? x)))
  (cond ((null? tree) 0)
        ((node? tree) 1)
        (else (+ (count-leaves (car tree))
                 (count-leaves (cdr tree))))))

(define-test (leaves-to-count)
  (check (= (count-leaves '(1 2 3 4))
            4))
  (check (= (count-leaves '((1 2) (3 4)))
            4))
  (check (= (count-leaves '((1 2) 3 (4 (5)) 6)))
         6))

(run-registered-tests)
