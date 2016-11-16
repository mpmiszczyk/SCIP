(load "../test-manager/load.scm")

(define (reverse l)
  (define (iter l acc)
    (if (null? l)
        acc
        (iter (cdr l)
              (cons (car l) acc))))
  (iter l ()))

(define (deep-reverse deep-list)
  (map (lambda (x)
         (if (list? x)
             (deep-reverse x)
             x))
       (reverse deep-list)))

(define (deep-reverse deep-list)
  (define (iter l acc)
    (if (null? l)
        acc
        (let ((head (car l))
              (tail (cdr l)))
          (iter tail (cons (if (list? head)
                               (deep-reverse head)
                               head)
                           acc)))))
  (iter deep-list ()))

(define (deep-reverse deep-list)
  (if (not (list? deep-list))
      deep-list
      (map deep-reverse
           (reverse deep-list))))

(define-test (examples-from-book)
  (check (equal? (reverse
                  '((1 2) (3 4)))
                 '((3 4) (1 2))))
  (check (equal? (deep-reverse
                  '((1 2) (3 4)))
                 '((4 3) (2 1)))))

(run-registered-tests)
