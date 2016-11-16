(load "../test-manager/load.scm")

(define (node? t) (not (pair? t)))

(define (square-tree-rec tree)
  (cond ((null? tree) ())
        ((node? tree) (square tree))
        (else (cons (square-tree-rec (car tree))
                    (square-tree-rec (cdr tree))))))

(define (square-tree-map tree)
  (map (lambda (t)
         (if (node? t)
             (square t)
             (square-tree-map t)))
       tree))

(define (square-tree-map2 tree)
  (if (node? tree)
      (square tree)
      (map square-tree-map2 tree)))

(define (map-tree fun tree)
  (if (node? tree)
      (fun tree)
      (map (lambda (t)
             (map-tree fun t))
           tree)))

(define (square-map-tree1 tree)
  (map-tree square tree))

(define (map-tree-not-proper-list fun tree)
  (cond ((null? tree) ())
        ((node? tree) (fun tree))
        (else (cons (map-tree-not-proper-list fun (car tree))
                    (map-tree-not-proper-list fun (cdr tree))))))

(define (square-map-tree2 tree)
  (map-tree-not-proper-list square tree))


(define-test (test-all-functions)
  (map (lambda (square-fun)
         (check (equal? (square-fun '(1 (2 3) 4 (4 5)))
                        '(1 (4 9) 16 (16 25)))))
       (list square-tree-rec
             square-tree-map
             square-tree-map2
             square-map-tree1)))

(define-test (only-two-will-handle-both-lists-and-pairs)
  (map (lambda (square-fun)
         (equal? (square-fun
                  (cons 1 (cons 2 3)))
                 (cons 1 (cons 4 9))))
       (list square-tree-rec
             square-map-tree2)))

(run-registered-tests)
