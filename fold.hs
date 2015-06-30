import Criterion.Main

fun1 :: Integer -> Integer
fun1 x = ((sum (filter even [0 .. x])) * 2)

fun2 :: Integer -> Integer
fun2 x = sum (map (*2) (filter even [0 .. x]))

fun3 :: Integer -> Integer
fun3 x = ((sum [0, 2 .. x]) * 2)

fun4 :: Integer -> Integer
fun4 x = let y = x `div` 2 in 2 * y * (y+1)

main :: IO ()
main = defaultMain [
  bgroup "fun1" [ bench "1000"  $ whnf fun1 1000
               , bench "1000000"  $ whnf fun1 1000000
               ],
  bgroup "fun2" [ bench "1000" $ whnf fun2 1000
                , bench "1000000" $ whnf fun2 1000000
                ],
   bgroup "fun3" [ bench "1000" $ whnf fun3 1000
                 , bench "1000000" $ whnf fun3 1000000
                 ],
    bgroup "fun4" [ bench "1000" $ whnf fun4 1000
                  , bench "1000000" $ whnf fun4 1000000
                  ]
  ]
