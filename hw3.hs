-- Danielle Levy

module HW3 where

-- Base 4
data NZDigit = One | Two | Three deriving Show
data Digit = Zero | NZ NZDigit deriving Show
data Base4Num = Single Digit | Multiple NZDigit [Digit] deriving Show

-- 1
toBase4 :: Base4Num -> String
toBase4 (Single digit) = digitToString digit
toBase4 (Multiple nzDigit digits) = nzDigitToString nzDigit ++ (digitListToString digits)

nzDigitToString :: NZDigit -> String
nzDigitToString One = "1"
nzDigitToString Two = "2"
nzDigitToString Three = "3"

digitToString :: Digit -> String
digitToString Zero = "0"
digitToString (NZ nzDigit) = nzDigitToString nzDigit

digitListToString :: [Digit] -> String
digitListToString [] = ""
digitListToString [digit] = digitToString digit
digitListToString (x:xs) = digitToString x ++ digitListToString xs

-- 2
toNum  :: Base4Num -> Int
toNum (Single digit) = digitToInt digit
toNum (Multiple nzDigit digits) = foldr (+) 0 (map funcForMap (createIndexDigitList(toIntList (Multiple nzDigit digits))))

nzDigitToInt :: NZDigit -> Int
nzDigitToInt One = 1
nzDigitToInt Two = 2
nzDigitToInt Three = 3

digitToInt :: Digit -> Int
digitToInt Zero = 0
digitToInt (NZ nzDigit) = nzDigitToInt nzDigit

digitListToIntList :: [Digit] -> [Int]
digitListToIntList [] = []
digitListToIntList [digit] = [digitToInt digit]
digitListToIntList (x:xs) = digitToInt x : digitListToIntList xs

toIntList :: Base4Num -> [Int]
toIntList (Single digit) = [digitToInt digit]
toIntList (Multiple nzDigit digits) = nzDigitToInt nzDigit : (digitListToIntList digits)

createIndexDigitList :: [Int] -> [(Int, Int)]
createIndexDigitList xs = zip (reverse (take (length xs) [0, 1..])) xs

funcForMap :: (Int, Int) -> Int
funcForMap (index, digit) = (4 ^ index) * digit

-- 3
fromBase4 :: String -> Base4Num
fromBase4 [x] = Single (getDigit [x])
fromBase4 (x:xs) = Multiple (getNZDigit [x]) (getDigitList xs)

getNZDigit :: String -> NZDigit
getNZDigit "1" = One
getNZDigit "2" = Two
getNZDigit "3" = Three

getDigit :: String -> Digit
getDigit "0" = Zero
getDigit x = NZ (getNZDigit x)

getDigitList :: String -> [Digit]
getDigitList [] = []
getDigitList [x] = [getDigit [x]]
getDigitList (x:xs) = getDigit [x] : (getDigitList xs)

-- 4
fromNum :: Int -> Base4Num
fromNum x = fromBase4 (decToBase4 x)

decToBase4 :: Int -> String
decToBase4 0 = "0"
decToBase4 1 = "1"
decToBase4 2 = "2"
decToBase4 3 = "3"
decToBase4 x = (decToBase4 (x `div` 4)) ++ (decToBase4 (x `mod` 4))

-- Weighted Binary Tree
type Count = Int
data CNode t = Item Count t deriving Show
data CBinTree t = NULL | Node (CBinTree t) (CNode t) (CBinTree t) deriving Show

-- 5
addItem :: (Ord t) => (CBinTree t) -> t -> (CBinTree t)
addItem NULL t = Node NULL (Item 1 t) NULL
addItem (Node left (Item count val) right) t = if (t == val) then (Node left (Item (count + 1) val) right) else (if (t < val) then Node (addItem left t) (Item count val) right else Node left (Item count val) (addItem right t))

-- 6
maxCount :: (Ord t) => (CBinTree t) -> ( Maybe t ,Int)
maxCount NULL = (Nothing, 0)
--maxCount (Node NULL (Item count val) NULL) = (Just val, count)
maxCount cBinTree = let l = (getMaxCount cBinTree) in head (filter (\x -> snd x == l) (makeTupleList cBinTree))

makeTupleList :: (Ord t) => (CBinTree t) -> [( Maybe t ,Int)]
makeTupleList NULL = []
makeTupleList (Node left (Item count val) right) = (makeTupleList left) ++ [(Just val, count)] ++ (makeTupleList right)

getMaxCount :: (Ord t) => (CBinTree t) -> Int
getMaxCount NULL = 0
getMaxCount cBinTree = maximum (snd (unzip (makeTupleList (cBinTree))))
