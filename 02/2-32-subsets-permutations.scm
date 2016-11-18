(load "../test-manager/load.scm")


(define (subsets set)
  (if (empty? set)
      (new-set ())
      (sum-set (subsets (cdr set))
               (add-to-each (car set) (subsets (cdr set))))))

(define (subsets set)
  (if (empty? set)
      (new-set ())
      (let ((subsets-without-first (subset (cdr set)))
            (first (car set)))
        (sum-set subsets-without-first
                 (add-to-each first subsets-without-first)))))

(define sum-set append)

(define empty? null?)

(define new-set list)

(define (add-to-each element sets)
  (map (lambda (set) (sum-set (new-set element) set))
       sets))


(define-test (empty-set-produces-set-with-empty)
  (check (equal? (subsets '())
                 '(()))
         ))

(define-test (one-element-set-will-produce-two-subsetss)
  (check (equal? (subsets '(1))
                 '(() (1)))
         ))

(run-registered-tests)

(subsets (list 1 2 3))

