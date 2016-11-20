(load "../test-manager/load.scm")


(define (sum l)
  (fold + 0 l))

(define (triplets-sum n s)
  (filter (lambda (t)
            (= (sum t) s))
          (triplets n)))

;; TODO: There should be a way to generalize this, but it is not
;; obvious one.  Something with cartesian product.
;;
;; But again, this is not realy cartesian priduct, since we keep
;; c<b<a.  But we could create full cartesian plane and filter (on
;; sort unique, or being sorted)
;;
;; Still it's not the optimal implementation, There should be an
;; algorithm that is based on differences.
(define (triplets n)
  (flatmap (lambda (a)
             (flatmap (lambda (b)
                        (map (lambda (c)
                               (list c b a))
                             (range 1 (- b 1))))
                      (range 1 (- a 1))))
           (range 1 n)))

(define-test (simple-sum-triplets)
  (check (equal? (triplets-sum 6 6)
                 '((1 2 3)))))

(run-registered-tests)
