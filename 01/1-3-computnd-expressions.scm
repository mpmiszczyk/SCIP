;; Model of eveluation allows for opernds to be determined by compound
;; expressions
;; 
;; This is in some way allowed in Erlang to, but considered to be
;; exotic, and you have to watch for spacing
;;
;; if 1 > 0 ->
;;      erlang;
;;    true ->
;;      other_module
;; end:node()
;;

(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

