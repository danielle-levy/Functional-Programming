-- Danielle Levy

-- Lambda Calculus

Given the following expression (λx.λy.(λz.z)y) ( (λu.u) ((λv.v)y) )

-- 1. Reduce this expression to normal form using applicative order.
(λx.λy.(λz.z)y) ( (λu.u) ((λv.v)y) )
(λx.λy.(λz.z)y) ( (λu.u) y )
(λx.λy.(λz.z)y) ( y )
(λx.λu.(λz.z)u) ( y )
λu.(λz.z) u
λu.u
-- Done!

-- 2. Reduce this expression to normal form using normal order.
(λx.λy.(λz.z)y) ( (λu.u) ((λv.v)y) )
λy.(λz.z)y
λy.y
-- Done!

-- 3. Reduce the following expression to normal form:
(λx.λy. x ( x ( x y ) )) (λx. f x) n
(λy. (λx. f x) ( (λx. f x) ( (λx. f x) y ) )) n
λx. f x ( (λx. f x) ( (λx. f x) n ) )
λx. f x ( (λx. f x) ( f n ) )
λx. f x ( f (f n) )
f ( f (f n) )
-- Done!

Given the following definitions:
A = λx.λy.λz.xzy
B = λx.λy.y

-- 4. Show that ABABA = AA
A B A B A
(((A B) A) B) A
(((λx.λy.λz.xzy B) A) B) A
((λy.λz.Bzy A) B) A
((λz.BzA) B) A
(BBA) A
((BB)A)) A
((λx.λy.y B)A)) A
((λy.y) A)) A
A A
-- Done!

Given the following definitions:
S = λf.λg.λx. f x (g x)
I = λx.x

-- 5. What is the normal form of SII(SII)?
SII(SII)
((SI) I) ((SI) I)
((SI) I) ((SI) I)
((λf.λg.λx. f x (g x) I) I) ((SI) I)
((λg.λx. I x (g x)) I) ((SI) I)
(λx. I x (I x)) ((SI) I)
(λx. x (I x)) ((SI) I)
(λx. x x) ((SI) I) -- ((SI) I) == (λx. x x) by previous steps
(λx. x x) (λx. x x) 
-- Done!

-- 6. a

(λz. + ((λy.y) z) z) ((λy.y) (+ 3 1))


-- 6. b.

(λz.z z) (λf.λx.f (f x)) (λx. + 1 x) 2

-- 6. c.

(λf.λn.if (f n) n (+ 1 n)) (== 3) (* 2 4)
(λn.if ((== 3) n) n (+ 1 n)) (* 2 4)
(λn.if ((== 3) n) n (+ 1 n)) (8)
(if ((== 3) 8) 8 (+ 1 8))
9

