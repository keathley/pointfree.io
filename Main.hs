--
-- Copyright (c) 2006 Don Stewart - http://www.cse.unsw.edu.au/~dons/
-- GPL version 2 or later (see http://www.gnu.org/copyleft/gpl.html)
--
import System.Environment
 
 -- | 'main' runs the main program
 main :: IO ()
 main = getArgs >>= print . haqify . head
  
  haqify s = "Haq! " ++ s
