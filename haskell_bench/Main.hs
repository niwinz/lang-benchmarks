{-# LANGUAGE BangPatterns #-}
module Main where

import Control.Monad (replicateM)
import System.Random (newStdGen, randomRs)
import Data.Time.Clock (getCurrentTime, diffUTCTime)
import Text.Printf (printf)

sumLists :: [[Integer]] -> Integer
sumLists = sum . concat

randomList :: IO [Integer]
randomList = do g <- newStdGen
                let !rs = take 500 $ randomRs (0, 100) g
                return rs

showDiffTimeInMs dt = timeInMs ++ " msecs"
         where timeInMs = init . show $ 1000 * dt

main = do randomLists <- replicateM 100 randomList

          before <- getCurrentTime
          let !result = sumLists randomLists
          after <- getCurrentTime

          printf $ "[Haskell ! Array Sum] Elapsed time: " ++ (showDiffTimeInMs $ diffUTCTime after before) ++ " ( Result: " ++ show result ++ " )\n"
