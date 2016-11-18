(load "../test-manager/load.scm")

(define (accumulate fun initial-value sequence)
  (if (null? sequence)
      initial-value
      (fun (car sequence)
           (accumulate fun initial-value (cdr sequence)))))

;; FIXME not so simple 
(define (count-leaves tree)
  (define (node? t) (not (pair? t)))
  (accumulate (lambda (t sum)
                (newline)
                (display t)
                (+ sum (if (node? t)
                           1
                           (count-leaves (car t)))))
              0
              tree))

(define-test (leaves-to-count)
  (check (= (count-leaves '(1 2 3 4))
            4))
  (newline)
  (display "simple-list")
  (check (= (count-leaves '((1 2) (3 4)))
            4))
  (check (= (count-leaves '((1 2) 3 (4 (5)) 6))
            6)))

(run-registered-tests)
