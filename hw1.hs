-- Danielle Levy

-- 1
shiftString :: String -> String
shiftString "" = ""
shiftString x = last x : init x

-- 2
--- helper function: recursively shifts x
recursiveShift :: String -> String -> Int -> Bool
recursiveShift x y 0 = x == y
recursiveShift x y n = x == y || recursiveShift (shiftString x) y (n - 1)

isShifted :: String -> String -> Bool
isShifted x y = recursiveShift (shiftString x) y (length x)

-- 3
stupidListOp :: [Int] -> [Int]
stupidListOp [] = []
stupidListOp (x:xs) = if x > 0 then take x ([x, x..]) ++ stupidListOp xs else stupidListOp xs

-- 4
--- helper function: given the previous line of the triangle, calculates and ceates the current line
createCurLine :: [Int] -> [Int]
createCurLine [] = []
createCurLine prevline = sum (take 2 (prevline)) : createCurLine (tail prevline)

pascalLine :: Int -> [Int]
pascalLine 0 = [1]
pascalLine n = 1 : createCurLine(pascalLine (n-1))

-- 5 ID card validation function
--- 5.1
--- helper function: converts positive Integers to a list of its digits
toDigitsNoPadding :: Integer -> [Integer]
toDigitsNoPadding 0 = []
toDigitsNoPadding x = if x < 0 then [] else  toDigitsNoPadding (x `div` 10) ++ [(x `mod` 10)]

--- helper function: given a list of Integers, pads the list with 0s if it has less than 9 numbers in it
addPadding :: [Integer] -> [Integer]
addPadding x = if (length x > 0 && length x < 9) then addPadding (0 : x) else x

toDigits :: Integer -> [Integer]
toDigits x = addPadding (toDigitsNoPadding x)

--- 5.2
doubleEveryOther :: [Integer] -> [Integer]
doubleEveryOther [] = []
doubleEveryOther [x] = [x]
doubleEveryOther (x:y:xs) = x : ((2 * y) : doubleEveryOther xs)

--- 5.3
sumDigits :: [Integer] -> Integer
sumDigits [] = 0
sumDigits (x:xs) = if x == 0 then sumDigits xs else  (x `mod` 10) + sumDigits ((x `div` 10) : xs)

--- 5.4
validate :: Integer -> Bool
validate x = ((sumDigits (doubleEveryOther (toDigits x))) `mod` 10) == 0


