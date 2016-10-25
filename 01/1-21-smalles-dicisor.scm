(define (smallest-divisor a)
  (find-next-divisor a 2))

(define (find-next-divisor of from)
  (if (= 0 (remainder of from))
      from
      (find-next-divisor of (+ from 1))))
