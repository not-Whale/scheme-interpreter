; Бинарные операции
(define-syntax last2                                                    
  (syntax-rules ()
    ((last2 op xs)
     (cons (op (car (cdr xs)) (car xs)) (cdr (cdr xs))))))

; Операции сравнения
(define-syntax bool-2
  (syntax-rules (= > <)
    ((bool-2 = xs)
     (cons (or (and (= (car (cdr xs)) (car xs)) -1) 0)
           (cdr (cdr xs))))
    ((bool-2 > xs)
     (cons (or (and (> (car (cdr xs)) (car xs)) -1) 0)
           (cdr (cdr xs))))
    ((bool-2 < xs)
     (cons (or (and (< (car (cdr xs)) (car xs)) -1) 0)))))

; Логические операции
(define-syntax lp
  (syntax-rules (not and or)
    ((lp not xs)
     (cons (or (and (= (car xs) 0) -1) 0) (cdr xs)))
    ((lp and xs)
     (cons (or (and (or (= (car xs) 0) (= (car (cdr xs)) 0)) 0) -1)
           (cdr (cdr xs))))
    ((lp or xs)
     (cons (or (and (and (equal? (car xs) 0) (equal? (car (cdr xs)) 0)) 0) -1)
           (cdr (cdr xs))))))

; Поиск номера+1 элемента в списке, начиная с определенной
; позиции с движением вправо
(define (find-num+1 elem vec num)
  (and (< num (vector-length vec))
       (if (equal? elem (vector-ref vec num))
           (+ num 1)
           (find-num+1 elem vec (+ num 1)))))

; Поиск номера элемента в списке, начиная с определенной
; позиции с движением влево
(define (find-reverse elem vec num)
  (and (>= num 0)
       (if (equal? elem (vector-ref vec num))
           num
           (find-reverse elem vec (- num 1)))))               

; Объявление предикатов (моя гордость)
(for-each (lambda (x)
            (eval `(define (,(string->symbol(string-append(symbol->string x) "?"))
                            question)
                     (equal? question ',x))
                  (interaction-environment)))
          '(+ - * /
            mod neg
            = > <
            not and or
            drop swap dup over rot depth
            define end exit
            if endif else
            for endfor
            variable
            set
            clear
            ))                                               

; Простейшие процедуры
(define (neg xs)
  (append (list (- (car xs))) (cdr xs)))

(define (swap xs)
  (append (list (car (cdr xs)) (car xs)) (cdr (cdr xs))))

(define (dup xs)
  (append (list (car xs) (car xs)) (cdr xs)))

(define (over xs)
  (append (list (car (cdr xs)) (car xs) (car (cdr xs))) (cdr (cdr xs))))

(define (rot xs)
  (append (list (car (cdr (cdr xs))) (car (cdr xs)) (car xs)) (cdr (cdr (cdr xs)))))

(define (depth xs)
  (cons (length xs) xs))

; Удаление последнего объявления определенной функции
(define (clear elem as)
  (define (iter xs as2)
    (if (equal? elem (car (car as2)))
        (reverse (append (reverse (cdr as2)) xs))
        (iter (cons (car as2) xs) (cdr as2))))
  (iter '() as))
