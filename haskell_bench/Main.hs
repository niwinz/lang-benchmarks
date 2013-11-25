{-# LANGUAGE BangPatterns #-}
module Main where

import Control.Monad (replicateM)
import Network.CGI.Protocol (maybeRead)
import System.Environment (getArgs)
import System.Random (newStdGen, randomRs)
import Data.Time.Clock (getCurrentTime, diffUTCTime)
import Text.Printf (printf)

defaultLists = 100
defaultElements = 500

sumLists :: [[Int]] -> Int
sumLists = sum . concat

randomList n = do g <- newStdGen
                  let !rs = take n $ randomRs (0, 100) g
                  return rs

showDiffTimeInMs dt = timeInMs ++ " msecs"
         where timeInMs = init . show $ 1000 * dt

readInt :: String -> Int
readInt = read

readIntOr :: Int -> String -> Int
readIntOr d s = case parsedString of
                   Nothing -> d
                   Just x -> x
                where parsedString = maybeRead s :: Maybe Int

parseArgs :: [String] -> (Int, Int)
parseArgs [] = (defaultLists, defaultElements)
parseArgs (x:[]) = (readIntOr defaultLists x, defaultElements)
parseArgs (x:y:_) = (readIntOr defaultLists x, readIntOr defaultElements y)

main = do args <- getArgs
          let (listAmount, elementAmount) =  parseArgs args

          randomLists <- replicateM listAmount $ randomList elementAmount

          before <- getCurrentTime
          let !result = sumLists randomLists
          after <- getCurrentTime

          printf $ "[Haskell ! Array Sum] Elapsed time: " ++ (showDiffTimeInMs $ diffUTCTime after before) ++ " ( Result: " ++ show result ++ " )\n"
