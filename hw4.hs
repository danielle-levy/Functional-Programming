-- Danielle Levy

module HW4 where

-- sCalc

-- 1
data TokenType = TokLeftPar | TokRightPar | TokConstant | TokVar | TokOp deriving(Show, Eq)
type Token = (TokenType, String)

lexer :: String -> [Token]
lexer [] = []
lexer (' ':xs) = lexer xs
lexer ('+':xs) = (TokOp, "+") : lexer xs
lexer ('*':xs) = (TokOp, "*") : lexer xs
lexer ('-':xs) = (TokOp, "-") : lexer xs
lexer ('/':xs) = (TokOp, "/") : lexer xs
lexer ('(':xs) = (TokLeftPar, "(") : lexer xs
lexer (')':xs) = (TokRightPar, ")") : lexer xs
lexer (ch:xs) =
    let x = (removeSpaces (ch:xs))
        i = (lexerHelper x)
    in if (isDigit ch) then (TokConstant, fst i) : lexer (snd i) else (TokVar, fst i) : lexer (snd i)

lexerHelper :: String -> (String, String)
lexerHelper [] = ("", "")
lexerHelper (ch:[]) = ([ch], "")
lexerHelper xs = let i = (firstFalseLoc (map (isNotOpOrPar) xs)) in (take i xs, drop i xs)

removeSpaces :: String -> String
removeSpaces = filter (/= ' ')

isDigit :: Char -> Bool
isDigit ch = (ch >= '0') && (ch <= '9')

isNotOpOrPar :: Char -> Bool
isNotOpOrPar ch = not ((ch == '+') || (ch == '*') || (ch == '-') || (ch == '/') || (ch == '(') || (ch == ')'))

firstFalseLoc :: [Bool] -> Int
firstFalseLoc [] = 0
firstFalseLoc (x:xs) = if x == False then 0 else (firstFalseLoc xs) + 1

-- 2

-- 2.A
data ArithOp = Add | Sub | Mult | Div deriving Show
data Expr = Const Int | NamedVar String | BinOp Expr ArithOp Expr | Par Expr deriving Show

-- 2.B
five = Const 5
xAddFive = BinOp (NamedVar "x") Add (Const 5)
yAdd = BinOp (BinOp (NamedVar "y") Add (BinOp (Const 2) Mult (NamedVar "x"))) Sub (Const 3)
yAddPar = BinOp (NamedVar "y") Add $ BinOp (Const 2) Mult (Par (BinOp (NamedVar "x") Sub (Const 3)))

-- 2.C
type Dictionary = [(String, Int)]
calc_expr :: Expr -> Dictionary -> Maybe Int
calc_expr (Const x) _ = Just x
calc_expr (NamedVar var) [] = Nothing
calc_expr (NamedVar var) dict = getDictValue dict var
calc_expr (BinOp x op y) dict = performOp op (calc_expr x dict) (calc_expr y dict)
calc_expr (Par expr) dict = calc_expr expr dict

getDictValue :: Dictionary -> String -> Maybe Int
getDictValue dict varName =
    let i = (filter (\item -> (fst item) == varName) dict)
    in if (length i == 0) then Nothing else Just $ snd (head i)

performOp :: ArithOp -> Maybe Int -> Maybe Int -> Maybe Int
performOp Add (Just x) (Just y) = Just $ x + y
performOp Sub (Just x) (Just y) = Just $ x - y
performOp Mult (Just x) (Just y) = Just $ x * y
performOp Div (Just x) (Just 0) = Nothing
performOp Div (Just x) (Just y) = Just $ x `div` y
performOp op _ _ = Nothing


