{-# LANGUAGE FlexibleContexts #-}

--Nos Santos Izquierdo Field , PRIME GRIMOIRE SPELLS v0.0.0.2
-- Authors
--  Enrique Santos
--  Vicent Nos

module Main where

import System.Environment
import System.Exit
import System.Console.CmdArgs

import Data.List.Ordered
import Data.List.Split 
import Data.List (subsequences)

import Data.Numbers.Primes
import qualified Math.NumberTheory.Primes as P
import Math.NumberTheory.ArithmeticFunctions
import Math.NumberTheory.Powers.Modular
import Math.NumberTheory.Powers.Squares
import Codec.Crypto.RSA.Pure



prim n = read ((splitOn " " $ show (P.nextPrime n)) !! 1)::Integer


nsifc n base tries
	| out2 /= 1 && out2 /= n = (div n out2,out2) 
	| out /=1 && out /= n = (div n out,out)
	| out3 /= 1 && out3 /= n = (div n out3,out3) 
	| out4 /=1 && out4 /= n = (div n out4,out4)
	| out5 /= 1 && out5 /= n = (div n out5,out5) 
	| out6 /=1 && out6 /= n = (div n out6,out6)
	| out7 /= 1 && out7 /= n = (div n out7,out7) 
	| out8 /=1 && out8 /= n = (div n out8,out8)

	| otherwise = (0,0)
	where
	
	--(nearsquare) = 2^(logBase 2 n)
	primesc = nub $ sort $ map prim [1..n]	
	out =  head $ reverse ([1] ++ (filter (\r-> r/=1 && r/=2 ) $ map (\x-> gcd (n) (tryperiod ((n)) ((n)^2+x^2) x)) [2^base..2^base+tries]) )
	out2 = head $ reverse ([1]++ (filter (\x-> x/=1 && x/=2) $ map (\x-> gcd (n) (tryperiod ((n)) ((n)^2-x^2) x)) [2^base..2^base+tries]))
	out3 = head $ reverse ([1]++ (filter (\r-> r/=1 && r/=2 ) $ map (\x-> gcd (n) (tryperiod ((n)) ((n)^3+x^3) x)) [3^base..3^base+tries]))
	out4 = head $ reverse ([1]++ (filter (\x-> x/=1 && x/=2) $ map (\x-> gcd (n) (tryperiod ((n)) ((n)^3-x^3) x)) [3^base..3^base+tries] ))
	out5 =  head $ reverse ([1] ++ (filter (\r-> r/=1 && r/=2 ) $ map (\x-> gcd (n) (tryperiod ((n)) ((n)^5+x^5) x)) [5^base..5^base+tries]) )
	out6 = head $ reverse ([1]++ (filter (\x-> x/=1 && x/=2) $ map (\x-> gcd (n) (tryperiod ((n)) ((n)^5-x^5) x)) [5^base..5^base+tries]))
	out7 = head $ reverse ([1]++ (filter (\r-> r/=1 && r/=2 ) $ map (\x-> gcd (n) (tryperiod ((n)) ((n)^7+x^7) x)) [7^base..7^base+tries]))
	out8 = head $ reverse ([1]++ (filter (\x-> x/=1 && x/=2) $ map (\x-> gcd (n) (tryperiod ((n)) ((n)^7-x^7) x)) [7^base..7^base+tries] ))




sp s l = nub $ sort $  concat $ map (\x-> map (\y-> x*y) (map (\e-> prim (e*2) ) [(s)..(s)+l]) ) (map (\t-> prim (t*3)) [0,(s)..(s)+l])




ex = 1826379812379156297616109238798712634987623891298419


tryperiod n period m = (powMod (powMod (m) ex n) (modular_inverse ex period) n) - (m)

{--
-- | Cypher 'm', and tries to uncypher using 'period' as the subgroup order
tryperiod n period m = 
   m == powMod c xe n   -- uncypher c, and test if equal to original message
   where
   c  = powMod m ex n   -- cypher m
   -- 'xe' would be the privKey, inverse of 'ex', if 'period' was a subgroup order
   xe = modular_inverse ex period
--}   

primetosquare :: Integer -> [Integer]
{- | Search for squares 'o2' and check if subtracting (n - 1) is prime.  -}
primetosquare n = candidates ini (ini^2)
   where
   ini = integerSquareRoot (n - 1)
   candidates i i2
      -- | i > limit    = []
      | isPrime x = x : candidates o o2
      | otherwise = candidates o o2
      where 
      o  = i + 1
      o2 = i2 + i + o   -- o2 = (i + 1)^2 = i^2 + i + (i + 1)
      x  = o2 - n + 1   -- (n - 1 + x) must be a perfect square 


--
--
main = do  
    args <- getArgs                  -- IO [String]
    progName <- getProgName          -- IO String
    print args
    let (n : st :  m : _) = args
    -- let n = args !! 0
    -- let st = args !! 1
    -- let e = args !! 2
    -- let m = args !! 3

    let (factorA,factorB) = nsifc (read n::Integer) (read st::Integer) (read m::Integer)
    
    putStrLn "Public Key" 
    
    print $ (read n::Integer)

    putStrLn $ "Factors"

    print $ "P " ++ show factorB

    print $ "Q " ++ show factorA
    
    putStrLn $ "Prime grimoire spells  v0.1"

