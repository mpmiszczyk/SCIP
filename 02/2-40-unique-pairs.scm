(load "../test-manager/load.scm")


(define (range from to)
  (if (> from to)
      ()
      (cons from
            (range (+ 1 from) to))))

(define (unique-pairs n)
  (flatmap (lambda (x)
             (map (lambda (y)
                    (list y x))
                  (range 1 (- x 1))))
           (range 1 n)))

(define (sum l)
  (fold + 0 l))

(define (prime? n)
    (every (lambda (d)
             (not (divisible? n d)))
           (range 2 (sqrt n))))

(define (prime-sum-pairs n)
  (define (append-sum l)
    (append l
            (list (sum l))))
  (define (prime-sum? l)
    (prime? (sum l)))
  (define (divisible? a b)
    (= (remainder a b) 0))
  (map append-sum
       (filter prime-sum?
               (unique-pairs n))))

(define-test (simple-pairs)
  (check (equal? (unique-pairs 2)
                 '((1 2))))
  (check (equal? (unique-pairs 3)
                 '((1 2) (1 3) (2 3)))))

(define-test (simple-ranges)
  (check (equal? (range 1 3)
                 (list 1 2 3)))
  (check (equal? (range 3 1)
                 (list))))


(define-test (simple-prime-sum-pairs)
  (check (equal? (prime-sum-pairs 2)
                 '((1 2 3))))
  (display "first pair")
  (check (equal? (prime-sum-pairs 3)
                 '((1 2 3) (2 3 5))))) ; without (1 3 4)

(run-registered-tests)
