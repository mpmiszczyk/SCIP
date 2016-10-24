;; recursive
(define (f-r n)
  (if (< n 3)
      n
      (+ (f-r (- n 1))
         (* 2 (f-r (- n 2)))
         (* 3 (f-r (- n 3))))))

;; iterative
(define (f-i n)
  (define (iter n-3 n-2 n-1 i)
    (cond ((>= i n) n-1)
          (else (iter n-2
                      n-1
                      (+ (* 1 n-1) ;; could use let, but don't know how
                         (* 2 n-2)
                         (* 3 n-3))
                      (+ i 1)))))
    (iter 0 1 2 2))
