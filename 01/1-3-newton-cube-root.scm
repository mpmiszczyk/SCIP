




(define (cube-root x)
  (define (try guess)
    (if (good-enough? guess)
        guess
        (try (improve guess))))

  (define (good-enough? guess)
    (< (abs (- x (* guess guess guess)))
       (* x 0.0000001)))

  (define (improve guess)
    (/ (+ (/ x (* guess guess))
          (* 2 guess))
       3))

  (try 1.0))
