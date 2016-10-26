(define (f g) (g 2))

(= (f square)
   (square 2)
   4)

(= (f (lambda (x) (* x (+ x 1))))
   ((lambda (x) (* x (+ x 1))) 2)
   (* 2 ( + 2 1))
   6)


(= (f f)
   (f (lambda (g) (g 2)))
   ((lambda (g) (g 2))
    (lambda (x) (x 2)))
   ((lambda (x) (x 2)) 2)
   (2 2)) ;; error -> 2 not applicable
;; but this wasn't so obvius for me,
;;
;; I feel like I just assumed that it will work, just like some sort
;; of wishfull thinking, exectly when I shouldn't
;;
;; Abstracting with `lambda`'s rather than named functions helped a
;; lot, maybe that's a clue how to reason about it
