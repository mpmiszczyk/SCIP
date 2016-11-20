(load "../test-manager/load.scm")


(define (range a b)
  (iota b a))

(define (check? a b)
  (every (lambda (condition)
           (not (condition a b)))
         (list same-row
               same-column
               same-back-diagonal
               same-forward-diagonal)))
(define (same-row a b)
  (= (row a) (row b)))
(define (same-column a b)
  (= (column a) (column b)))
(define (same-forward-diagonal a b)
  (= (+ (row a) (column a))
     (+ (row b) (column b))))
(define (same-back-diagonal a b)
  (= (- (row a) (column a))
     (- (row b) (column b))))

(define position cons)
(define row car)
(define column cdr)
(define (add position solution)
  (cons position solution))

;; TODO: there are few additional ways to write this function
;; (especialy ordering of maps and filters), it would be nice to find
;; out which one is the best
;;
;; on way would be to start with all positions in first row, and build
;; on it?
;;
;; Fuck; I've just realized that this funcitn was already
;; half-implemented, and all I had to do was to implement `safe?`
;; function.  Still, it's nive I've managed to come up with close
;; enough idea myself.  Look into the book for propore implemenation.
;;
;;
(define (queen-puzzle size)
  (define (queen-puzzle-step column solutions)
    (if (= column 0)
        solutions
        (queen-puzzle-step
         (- column 1)
         (let ((positions (map (lambda (row)
                                 (position column row))
                               (range 1 size))))
           (flatmap (lambda (position)
                      (filter no-check?
                              (map (lambda (solution)
                                     (add position solution))
                                   solutions)))
                    positions)))))

  (define (no-check? new-solution)
    (let ((new-position (car new-solution))
          (old-positions (cdr new-solution)))
      (every (lambda (position)
               (check? position new-position))
             old-positions)))

  (queen-puzzle-step size '(())))



(define-test (simplest-board)
  (check (equal? (queen-puzzle 1)
                 (list (list (cons 1 1))))))

(define-test (known-solutions)
  (define (check-num-of-soulutions size count)
    (check (equal? (length (queen-puzzle size))
                   count)))
  (check-num-of-soulutions 1 1)
  (check-num-of-soulutions 2 0)
  (check-num-of-soulutions 3 0)
  (check-num-of-soulutions 4 2)
  (check-num-of-soulutions 8 92))

(run-registered-tests)
