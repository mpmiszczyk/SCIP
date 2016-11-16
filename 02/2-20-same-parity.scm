(load "../test-manager/load.scm")


(define (same-parity . args)
  (let ((first (car args)))
    (filter (lambda (n) (eq? (odd? n)
                             (odd? first)))
            args)))

(define (filter pred? lst)
  (if (null? lst)
      ()
      (let ((head (car lst))
            (tail (cdr lst)))
        (if (pred? head)
            (cons head
                  (filter pred? tail))
            (filter pred? tail)))))



(define-test (examples-from-book)
  (check (equal? (same-parity 1 2 3 4 5 6 7)
                 (list 1 3 5 7)))
  (check (equal? (same-parity 2 3 4 5 6 7)
                 (list 2 4 6))))

(run-registered-tests)
