import qualified Data.Map.Strict as M
import System.IO.Unsafe (unsafePerformIO)

nullWordMap :: M.Map Char Int
nullWordMap = M.fromList [ (c, 0) | c <- ['a'..'z'] ]

wordToMap :: String -> M.Map Char Int
wordToMap xs = M.unionWith (+) nullWordMap $ M.fromListWith (+) $ map pairKey xs
  where pairKey x = (x,1)

wordDifference :: String -> String -> M.Map Char Int
wordDifference s1 s2 = M.unionWith (-) (wordToMap s1) (wordToMap s2)

scrabble :: String -> String -> Bool
scrabble board word = nBlanks >= nMissing
  where
    diffMap = wordDifference board word
    nBlanks = M.findWithDefault 0 '?' diffMap
    nMissing = sum [ -x | (_,x) <- M.toList diffMap, x < 0]

-- don't mind me, just doing IO things where I shouldn't
enable1 :: [String]
enable1 = unsafePerformIO $ do
  f <- readFile "enable1.txt"
  return $ words f

longest :: String -> String
longest board =
  snd $ maximum $
  [ (length word, word) | word <- enable1, scrabble board word ]

letterScore :: Char -> Int
letterScore x | x `elem` "lsunrtoaie" = 1
              | x `elem` "gd" = 2
              | x `elem` "bcmp" = 3
              | x `elem` "fhvwy" = 4
              | x == 'k' = 5
              | x `elem` "jx" = 8
              | x `elem` "qz" = 10
wordScore :: String -> String -> Int
wordScore board word = sum [ letterScore l | l <- word, l `elem` board ]

highest :: String -> String
highest board =
  snd $ maximum $
  [ (wordScore board word, word) | word <- enable1, scrabble board word ]
