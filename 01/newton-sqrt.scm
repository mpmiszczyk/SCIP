;; Just like in videos
;;



(define (sqrt x)
  "finds y such y^2 = x"
  ;; so 0 = x - y^2
  ;; and for given x, we find y
  ;; so it's function of y
  ;; to which we would like to find 0
  (newton (lambda (y)
            (- x (* y y)))
          1.0))


(define (newton fun guess)
  "finds x for which (fun x) equals 0"
  (define dfun (df fun))
  (fixed-point (lambda (y)
                 (- y
                    (/ (fun y)
                       (dfun y))))
               guess))


(define (fixed-point fun initial-guess)
  "finds x such (fun x) equals x"
  (define (iterate guess)
    (if (good-enough? guess)
        guess
        (iterate (fun guess))))
  (define (good-enough? guess)
    (< (abs (- guess
               (fun guess))) ; (fun guess) called twice in each iteration
       0.0000001))
  (iterate initial-guess))
;; in HP videos the use two-parameter iterate funcion, which allows to
;; call (fun guess) only once, but I think this one is much easier to
;; read
;;
;; while it is implemented "just like" in lecture, i do have some
;; issues with the way we improve over our guess, It will work only
;; for few functions, and only if you start at suitable point.


(define (df fun)
  "produce funcion calculating deriverang for given x"
  (define dx 0.000000001)
  (lambda (x)
    (/ (- (fun (+ x dx))
          (fun x))
       dx))
  )
