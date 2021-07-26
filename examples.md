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
            define gcd 
                =0? if drop exit endif 
                swap over mod 
                gcd 
            end 
            90 99 gcd 
            234 8100 gcd) '())
=> (18 9)
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
=> (0 1 1 2 3 5 8 13 21 34 55)
```

```
(interpret #(0 if 1 endif) '())
=> ()
```

```
(interpret #(0 if 1 else 2 endif) '())
=> (2)
```

```
(interpret #(-1 if 1 endif) '())
=> (1)
```

```
(interpret #(-1 if 1 else 2 endif) '())
=> (1)
```

```
(interpret #(define -- 1 - end define -- 2 - end clear -- 5 --) '())
=> (4)
```

```
(interpret #(5 variable x 3 x + 2 *) '())
=> (16)
```

```
(interpret #(3 variable x 5 set x x) '())
=> (5)
```