(load "../test-manager/load.scm")

(define (reverse lst)
  (define (iter lst acc)
    (if (null? lst)
        acc
        (iter (cdr lst)
              (cons (car lst) acc))))
  (iter lst ()))


(define-test (reversed-list)
  (check (equal? (reverse (list 1 2 3 4))
                 (list 4 3 2 1))))

(run-registered-tests)
