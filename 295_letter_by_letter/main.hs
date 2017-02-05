main :: IO ()
main = do
  a <- getLine
  b <- getLine
  putStrLn a
  putStr $ unlines $ letterByLetter a b
letterByLetter :: String -> String -> [String]
letterByLetter a b | a == b = []
letterByLetter a b = thisWord : (letterByLetter thisWord b)
  where
    pairs = zip a b
    equalPart = map fst $ takeWhile (\(x,y) -> x == y) pairs
    unequalPairs = drop (length equalPart) pairs
    thisWord =
      equalPart ++
      [snd $ head unequalPairs] ++
      (map fst $ tail unequalPairs)
