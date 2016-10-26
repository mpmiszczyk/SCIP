(load "../test-manager/load.scm")


;; data - centric
(define (repeated fun times)
  (define (iter i val)
    (if (= i times)
        val
        (iter (+ i 1) (fun val))))
  (lambda (x)
    (iter 0 x)))

;; function - composition - centric
(define (repeated fun times)
  (if (= times 1)
      fun
      (compose fun (repeated fun (- times 1)))))

(define (compose f g)
  (lambda (x)
    (f (g x))))

;; or all at the same time
(define (repeated fun times)
  (if (= times 1)
      fun
      (lambda (x)
        (fun ((repeated fun (- times 1))
              x)))))
;; and the last one was both hard to come by, and to read


(define-test (from-book)
  (check (= ((repeated square 2) 5)
            625)))

(run-registered-tests)
