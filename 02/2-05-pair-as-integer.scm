(load "../test-manager/load.scm")


(define (cons-int a b)
  (* (expt 2 a)
     (expt 3 b)))

(define (car-int p)
  (count-divides p 2))

(define (cdr-int p)
  (count-divides p 3))

(define (count-divides num div)
  (if (divides? num div)
      (+ 1 (count-divides (/ num div) div))
      0))

(define (count-divides num div)
  (define (count-iter n count)
    (if (divides? n div)
        (count-iter (/ n div) (+ count 1))
        count))
  (count-iter num 0))

(define (divides? num div)
  (= 0 (modulo num div)))



(define-test (simple-pair)
  (test-pairing-of 2 0)
  (test-pairing-of 3 30)
  (test-pairing-of 2 1))


(define (test-pairing-of a b)
  (let ((pair (cons-int a b)))
    (check (= (car-int pair)
              a))
    (check (= (cdr-int pair)
              b))))

(run-registered-tests)


