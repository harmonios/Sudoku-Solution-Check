;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname sudoku-forward) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
;;Kashif Moattar

;;(dupeandnumchecker a b) uses lists a and b to compare if duplicates exist, or if the numbers in the list exist in sudoku, thus outputting false or true
;;Examples:
(check-expect (dupeandnumchecker (cons 1 (cons 2 (cons 3 (cons 4 (cons 5 (cons 9 (cons 8 (cons 7 (cons 6 empty))))))))) (rest(cons 1 (cons 2 (cons 3 (cons 4 (cons 5
    (cons 9 (cons 8 (cons 7 (cons 6 empty))))))))))) false)
(check-expect (dupeandnumchecker (cons 1 (cons 2 (cons 2 (cons 4 (cons 5 (cons 9 (cons 8 (cons 7 (cons 6 empty))))))))) (rest(cons 1 (cons 2 (cons 2 (cons 4 (cons 5
    (cons 9 (cons 8 (cons 7 (cons 6 empty))))))))))) false)

;;dupeandnumchecker: (listOf Num) (listOf Num) -> boolean
(define (dupeandnumchecker a b) 
  (cond
    [(empty? b) false] ;;if list b is empty, thus, all values have been compared, or no value needs comparing, thus is the last number of a set to not have any duplicates or violate rules
    [(or (> (first a) 9) (> (first b) 9)) true] ;;If numbers of a, and b are above 9, then is is true because it violated the rules of sudoku
    [(or (< (first a) 1) (< (first b) 1)) true] ;;Same as above line if below 1
    [(= (first a) (first b)) true] ;;If the first value a is equal to b, then there is a duplicate, hence true
    [(not (= (first a) (first b))) (dupeandnumchecker a (rest b))] ;;Otherwise repeat this process
    [else false]))

;;Tests:
(check-expect (dupeandnumchecker (cons 0 (cons 2 (cons 3 (cons 4 (cons 5 (cons 9 (cons 8 (cons 7 (cons 6 empty))))))))) (rest(cons 0 (cons 2 (cons 3 (cons 4 (cons 5
    (cons 9 (cons 8 (cons 7 (cons 6 empty))))))))))) true)
(check-expect (dupeandnumchecker (cons 1 (cons 2 (cons 3 (cons 4 (cons 5 (cons 9 (cons 8 (cons 13 (cons 6 empty))))))))) (rest(cons 1 (cons 2 (cons 3 (cons 4 (cons 5
    (cons 9 (cons 8 (cons 13 (cons 6 empty))))))))))) true)

;;(check_solution a) uses a list of sudoku numbers and checks if it is true or false.
;;Examples:
(check-expect (check_solution (cons 1 (cons 2 (cons 3 (cons 4 (cons 5 (cons 9 (cons 8 (cons 7 (cons 6 empty)))))))))) true)
(check-expect (check_solution (cons 1 (cons 2 (cons 3 (cons 4 (cons 5 (cons 9 (cons 8 (cons 7 (cons 0 empty)))))))))) false)

;;check_solution (listOf Num) -> Boolean
(define (check_solution a)
  (cond
    [(empty? a) true] ;;If empty is true, because nothing else is needed to be checked
    [(equal? (dupeandnumchecker a (rest a)) #t) false] ;;If there is a dupe or violation, then the numbers are false
    [(equal? (dupeandnumchecker a (rest a)) #f) (check_solution (rest a))] ;;Otherwise, It continues until all values are tested, if so the first cond or 4th will say numbers are true. 
    [else true]
  ))

;;Tests:
(check-expect (check_solution (cons 2 (cons 3 (cons 4 (cons 5 (cons 9 (cons 8 (cons 7 (cons 6 empty))))))))) true)
(check-expect (check_solution (cons 3 (cons 8 (cons 1 (cons 2 (cons 6 (cons 7 (cons 9 (cons 4 (cons 5 empty)))))))))) true)
(check-expect (check_solution (cons 1 (cons 2 (cons 2 (cons 4 (cons 5 (cons 9 (cons 8 (cons 7 (cons 0 empty)))))))))) false)
(check-expect (check_solution (cons 1 (cons 1 (cons 3 (cons 4 (cons 5 (cons 9 (cons 8 (cons 7 (cons 1 empty)))))))))) false)
(check-expect (check_solution (cons 1 (cons 8 (cons 3 (cons 4 (cons 8 (cons 9 (cons 8 (cons 7 (cons 6 empty)))))))))) false)




