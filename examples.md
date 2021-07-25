# Примеры программ

Ниже представлены примеры программ на языке, для которого был реализован интерпретатор.

```
(interpret #(define abs 
                dup 0 < 
                if neg endif 
            end 
            9 abs 
            -9 abs) (quote ()))
⇒ (9 9)
```

```
(interpret #(define =0? dup 0 = end 
            define <0? dup 0 < end 
            define signum 
                =0? if exit endif 
                <0? if drop -1 exit endif 
                drop 
                1 
            end 
            0 signum 
            -5 signum 
            10 signum) (quote ()))
⇒ (1 -1 0)
```

```
(interpret #(define -- 1 - end 
            define =0? dup 0 = end 
            define =1? dup 1 = end 
            define factorial 
                =0? if drop 1 exit endif 
                =1? if drop 1 exit endif 
                dup -- 
                factorial 
                \* 
            end 
            0 factorial 
            1 factorial 
            2 factorial 
            3 factorial 
            4 factorial) (quote ()))
⇒ (24 6 2 1 1)
```

```
(interpret #(define =0? dup 0 = end 
            define =1? dup 1 = end 
            define -- 1 - end 
            define fib 
                =0? if drop 0 exit endif 
                =1? if drop 1 exit endif 
                -- dup 
                -- fib 
                swap fib 
                + 
            end 
            define make-fib 
                dup 0 < if drop exit endif 
                dup fib 
                swap -- 
                make-fib 
            end 
            10 make-fib) (quote ()))
⇒ (0 1 1 2 3 5 8 13 21 34 55)
```

```
(interpret #(define =0? dup 0 = end 
            define gcd 
                =0? if drop exit endif 
                swap over mod 
                gcd 
            end 
            90 99 gcd 
            234 8100 gcd) '())
⇒ (18 9)
```