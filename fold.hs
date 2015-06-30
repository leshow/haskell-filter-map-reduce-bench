import Criterion.Main

fun1 :: Integer -> Integer
fun1 x = ((sum (filter even [0 .. x])) * 2)

fun2 :: Integer -> Integer
fun2 x = sum (map (*2) (filter even [0 .. x]))

main :: IO ()
main = defaultMain [
  bgroup "fun1" [ bench "1000"  $ whnf fun1 1000
               , bench "1000000"  $ whnf fun1 1000000
               ],
  bgroup "fun2" [ bench "1000" $ whnf fun2 1000
                , bench "1000000" $ whnf fun2 1000000
                ]
  ]
