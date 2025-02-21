module Comp.BitArr
  ( BitArr
  , empty
  , appendBit
  , toString
  ) where

newtype BitArr = BitArr { getBits :: [Bool] }
  deriving (Eq, Show)

empty :: BitArr
empty = BitArr []

appendBit :: BitArr -> Bool -> BitArr
appendBit (BitArr bs) b = BitArr (bs ++ [b])

toString :: BitArr -> String
toString (BitArr bs) = map (\b -> if b then '1' else '0') bs

instance Semigroup BitArr where
  (BitArr a) <> (BitArr b) = BitArr (a ++ b)

instance Monoid BitArr where
  mempty = empty