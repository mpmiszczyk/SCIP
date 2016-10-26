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
;; in book they use little bit different divisoins
(define (newton fun initial-guess)
  (fixed-point (newton-transform fun) initial-guess))

(define (newton-transform fun)
  (lambda (x)
    (- x (/ (fun x)
            ((deriv fun) x)))))

(define (deriv fun)
  (lambda (x)
    (/ (- (fun (+ x dx))
          (fun (x)))
       dx)))

(define dx 0.000001) ;; but `dx` could be defined in `let`


(define (fixed-point fun initial-guess)
  "finds x such (fun x) equals x"
  (define (iterate guess)
    (let ((next (fun guess)))
      (if (close-enough? guess next)
          guess
          (iterate next))))
  (define (close-enough? a b)
    (< (abs (- a b)) ; (fun guess) called twice in each iteration
       0.0000001))
  (iterate initial-guess))
;; in HP videos the use two-parameter iterate funcion, which allows to
;; call (fun guess) only once, but I think this one is much easier to
;; read
;;
;; while it is implemented "just like" in lecture, i do have some
;; issues with the way we improve over our guess, It will work only
;; for few functions, and only if you start at suitable point.  And as
;; it turns out this seems to be well known issue.  The convergence
;; could be verified by checking if our error grows or not (the
;; difference calculated by good-enough? procedure).
;;


(define (df fun)
  "produce funcion calculating deriverang for given x"
  (define dx 0.000000001)
  (lambda (x)
    (/ (- (fun (+ x dx))
          (fun x))
       dx))
  )



;; it could be done in little more data-centric (vs behaviour-centric)
;; way with
(define (different-df fun x)
  (define dx 0.000000001)
  (/ (- (fun (+ x dx))
        (fun x))
       dx))
;; and than, for given fun
(define (dfun x)
  (different-df fun x))
;; I think that for most people comming from iterative programming
;; this approach will seem more familiar.
;;
;; It's somewhat like difference between factory and decorater
;; patterns.
;;
;; So if we look once again on out newton function
(define (newton fun guess)
  "finds x for which (fun x) equals 0"
  (define dfun (df fun))
  (fixed-point (lambda (y)
                 (- y
                    (/ (fun y)
                       (dfun y))))
               guess))
;; we could as well have written
(define (newton fun guess)
  "finds x for which (fun x) equals 0"
  (fixed-point (lambda (y)
                 (- y
                    (/ (fun y)
                       ((df fun) y))))
               guess))
;; but if we use the "data-centric" approach, we have no other choice
;; than define "named" local function
(define (newton fun guess)
  "finds x for which (fun x) equals 0"
  (define (dfun x) (different-df fun x))
  (fixed-point (lambda (y)
                 (- y
                    (/ (fun y)
                       (dfun y))))
               guess))
;; and now when I compare those to, while I still think that
;; `different-df` might have been easier to come up with (for me, for
;; now), the initial `df` is much cleaner to use


