(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (runtime) start-time))))

(define (report-prime elpased-time)
  (display " >>> ")
  (display elpased-time))


(define (search-for-primes from to)
  (cond ((even? from)
         (search-for-primes (+ 1 from) to))
        ((> from to)  'finish)
        (else (timed-prime-test from)
              (search-for-primes (+ 2 from) to))))


;; it is a pain that I still don't know how to handle lists :/
(define (prime?-iter n)
  "iterative version of primes"
  (define (iter i)
    (cond ((> i limit) #t)
          ((divider? i n) #f)
          (else (iter (+ i 1)))))
  (define limit (sqrt n))
  (define (divider? d of)
    (= (remainder of d) 0))
  (iter 2))

(define prime? prime?-iter)


;; since prime?-iter has squreroot n order of growth, callin it with
;; 100 hounder times bigger number should take 10 times more time
(define from 10000000000)
(define to (+ from 100))
(define from100 (* from 100))
(define to100 (+ from100 100))

(search-for-primes from to)
(newline)(display ">>> increase range")
(search-for-primes from100 to100)
