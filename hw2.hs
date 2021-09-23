-- Danielle Levy

module HW2 where

-- 1
makeDistinctInt :: [Int] -> [Int]
makeDistinctInt [] = []
makeDistinctInt (x:xs) = let l = makeDistinctInt xs in if elem x xs then l else x : l

-- 2
makeDistinctString :: String -> [Char]
makeDistinctString "" = ""
makeDistinctString (x:xs) = let l = makeDistinctString xs in if elem x xs then l else x : l

-- 3
multiplyLists :: [Int]->[Int] -> [(Int,Int)]
multiplyLists [] _ = []
multiplyLists _ [] = []
multiplyLists xs (y:ys) = zip xs (take (length xs) [y, y..]) ++ multiplyLists xs ys

-- 4
-- helper function: given a list of Ints returns a list of these Ints squared
squared :: [Int] -> [Int]
squared [] = []
squared (x:xs) = (x ^ 2) : (squared xs)

listSquares :: Int -> [Int]
listSquares 1 = [1]
listSquares x = take (floor (sqrt (fromIntegral x))) (squared [1, 2..])

-- 5
roundSquare :: Int -> Int
roundSquare x = round (sqrt (fromIntegral x))

-- 6
createTuples :: Int -> [(Int,Int)]
createTuples x = let l = listSquares x in multiplyLists l l

checkTupleSum :: Int -> (Int, Int) -> Bool
checkTupleSum n (x, y) = n == (x + y)

checkTuples :: Int -> [(Int,Int)] -> (Int, Int)
checkTuples n (x:xs) = if checkTupleSum n x then x else checkTuples n xs

sqrtTuple :: (Int, Int) -> (Int, Int)
sqrtTuple (x, y) = (roundSquare x, roundSquare y)

twoSqaures :: Int -> (Int, Int)
twoSqaures x = sqrtTuple (checkTuples x (createTuples x))

-- 7
findMinLoc :: Int -> [Int] -> Int
findMinLoc min (x:xs) = if min == x then 0 else (findMinLoc min xs) + 1

dropMin :: [Int] -> [Int]
dropMin [] = []
dropMin x = let i = (findMinLoc (minimum x) x) in take i x ++ drop (i+1) x

slowSort :: [Int] -> [Int]
slowSort [] = []
slowSort x = let l = minimum x in l : slowSort (dropMin x)

