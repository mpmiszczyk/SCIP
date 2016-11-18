(load "../test-manager/load.scm")

(define (accumulate fun initial sequence)
  (if (null? sequence)
      initial
      (fun (car sequence)
           (accumulate fun initial (cdr sequence)))))

(define (map2 fun sequence)
  (accumulate (lambda (x y) (cons (fun x) y)) () sequence))

(define (append2 seq1 seq2)
  (accumulate cons seq2 seq1))

(define (length2 seq)
  (accumulate (lambda (x len) (+ 1 len))
              0
              seq))


(define-test (test-map-implementation)
  (check (equal? (map2 square (list 0 1 2 3))
                 (list 0 1 4 9))))

(define-test (test-new-append)
  (let ((seq1 (list 2 3 4 5))
        (seq2 (list 6 8 9 10)))
    (check (equal? (append2 seq1 seq2)
                   (append seq1 seq2)))))

(define-test (test-new-length)
  (let ((seq (list 1 2 3 4 5 6)))
    (check (equal? (length2 seq)
                   (length seq)))))

(run-registered-tests)


