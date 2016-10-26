(define (half-interval-method f a b)
  (let ((a-value (f a))
        (b-value (f b)))
    (cond ((and (negative? a-value) (positive? b-value))
           (search f a b))
          ((and (positive? a-value) (negative? b-value))
           (search f b a))
          (else
           (error "Values ar not of opposite sing" a b)))))



(define (search f neg-point pos-point)
  (let ((midpoint (average neg-point pos-point)))
    (if (close-enoug? neg-point pos-point)
        midpoint
        (let ((test-value (f midpoint)))
          (cond ((positive? test-value)
                 (search f neg-point midpoint))
                ((negative? test-value)
                 (search f midpoint pos-point))
                (else midpoint))))))

(define (average a b)
  (/ (+ a b) 2))

(define (close-enoug? a b)
  (< (abs (- a b))
     0.0000001))
