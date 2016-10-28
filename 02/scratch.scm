(define pair (cons 'one 'two))

(define first (car pair))

(define second (cdr pair))


;; since our `pair` is not a proper list, we can not call it `head` and
;; `tail`, becouse `second` is not a list and
;(cdr second)
;; will throw an error.

;; Still, there is no difference between Scheme and Erlang, we just
;; created pair, and not a list, which, while not so easy, is totally
;; duable in Erlang.  And there's no differece between `car`
;; `erlang:hd` and `cdr` `erlang;tl`

;; Exept of functional definition, which in Scheme is mindblowing


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;  Lists  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (scale-list s lst)
  (if (null? lst)
      ()
      (cons (* s (car lst))
            (scale-list s (cdr lst)))))


(define (scale-list s lst)
  (define (iter lst acc)
    (if (null? lst)
        (reverse acc)
        (iter (cdr lst)
              (cons (* s (car lst))
                    acc))))
  (iter lst ()))

(define (reverse lst)
  (define (iter lst acc)
    (if (null? lst)
        acc
        (iter (cdr lst)
              (cons (car lst)
                    acc))))
  (iter lst ()))



(define (map fun lst)
  (define (iter lst acc)
    (if (null? lst)
        (reverse acc)
        (iter (cdr lst)
              (cons (fun (car lst))
                    acc))))
  (iter lst ()))

(define (scale-list s lst)
  (map (lambda (x) (* s x))
       lst))




;; to few arguments
;;
;; You can redefine `map` to return lambda rather then data, but it
;; will not simplify it's usage in any way
(define (map fun)
  (define (iter lst acc)
    (if (null? lst)
        (reverse acc)
        (iter (cdr lst)
              (cons (fun (car lst))
                    acc))))
  (lambda (lst)
    (iter lst ())))


;; with this definition `scale-list` takes only one argument, because
;; `map` return one-arugment lambda
(define scale-list
  (map (lambda (x) (* s x))))

;; you would have to do something like this, and go back to
;; data-centric design
(define (scale-list s lst)
  ((map (lambda (x) (* s x))) lst))
;; i think curring could solve this, but this was neither introduced,
;; or (?) present in scheme
