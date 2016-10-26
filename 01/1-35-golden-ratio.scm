(define (fixed-point fun initial-guess)
  (define (iter guess)
    (let ((next (fun guess)))
      (if (close-enough? guess next)
          next
          (iter next))))
  (define (close-enough? a b)
    (< (abs (- a b))
       0.0000001))
  (iter initial-guess))


(define (calculate-fi)
  (fixed-point (lambda (x) (+ 1 (/ 1 x)))
               1.))

(calculate-fi)
