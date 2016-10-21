(load "../test-manager/load.scm")



(define (double x)
  (+ x x))


(define-test (double)
  (check (= (double 2) 5)
         "with some message; if we fail"))

(define-test (double-other-way)
  (interaction
   (double 2)
   (produces 4)))

(run-registered-tests)

