(load "../test-manager/load.scm")

(define (last-pair lst)
  (let ((tail (cdr lst)))
    (if (null? tail)
        lst
        (last-pair tail))))

(define-test (last-of-list)
  (check (equal? (last-pair (list 23 72 149 34))
                 (list 34))))

(run-registered-tests)
