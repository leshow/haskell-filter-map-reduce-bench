##Haskell filter/map/fold benchmark

I had written this in Rust and used cargo to benchmark [here](https://github.com/leshow/rust-filter-map-reduce-bench)

The execution time was very fast in rust on my machine (500k ns), which got me
wondering how fast it might be in Haskell.

I'm no expert in Haskell, but I've written two implementations with only a
slight variation that I think are idiomatic.

EDIT: after talking with some people in the Haskell IRC, I've added an additional
implementation that runs significantly faster with only a slight variation. See
`fun3` in fold.hs.

Criterion was used to benchmark. To build this project:

```
git clone https://github.com/leshow/haskell-filter-map-reduce-bench
cd haskell-filter-map-reduce-bench
cabal sandbox init
cabal update
cabal install criterion
```

compile with:
```
ghc -O2 -package-db .cabal-sandbox/x86_64-linux-ghc-7.6.3-packages.conf.d/ fold.hs
```

then run:
```
./fold
```

you can also generate a pretty web page with graphs of the benchmark test
(after you've compiled) with:

```
./fold --output fold.html
```

##Results
on my machine:
```
benchmarking fun1/1000
time                 34.84 μs   (34.65 μs .. 35.01 μs)
                     1.000 R²   (1.000 R² .. 1.000 R²)
mean                 34.91 μs   (34.83 μs .. 35.01 μs)
std dev              289.6 ns   (223.0 ns .. 368.6 ns)

benchmarking fun1/1000000
time                 34.82 ms   (34.52 ms .. 35.17 ms)
                     1.000 R²   (1.000 R² .. 1.000 R²)
mean                 34.82 ms   (34.72 ms .. 34.95 ms)
std dev              239.0 μs   (169.7 μs .. 331.2 μs)

benchmarking fun2/1000
time                 37.69 μs   (37.38 μs .. 38.01 μs)
                     0.987 R²   (0.978 R² .. 0.993 R²)
mean                 45.95 μs   (43.00 μs .. 49.19 μs)
std dev              12.01 μs   (9.914 μs .. 13.17 μs)
variance introduced by outliers: 98% (severely inflated)

benchmarking fun2/1000000
time                 38.27 ms   (38.05 ms .. 38.42 ms)
                     1.000 R²   (1.000 R² .. 1.000 R²)
mean                 38.32 ms   (38.23 ms .. 38.41 ms)
std dev              185.4 μs   (141.7 μs .. 235.6 μs)

benchmarking fun3/1000
time                 10.05 μs   (10.00 μs .. 10.11 μs)
                     1.000 R²   (1.000 R² .. 1.000 R²)
mean                 10.03 μs   (10.00 μs .. 10.07 μs)
std dev              106.1 ns   (88.71 ns .. 129.9 ns)

benchmarking fun3/1000000
time                 12.65 ms   (9.922 ms .. 15.20 ms)
                     0.886 R²   (0.839 R² .. 1.000 R²)
mean                 10.48 ms   (10.05 ms .. 11.61 ms)
std dev              1.613 ms   (417.0 μs .. 3.110 ms)
variance introduced by outliers: 75% (severely inflated)

```
My quickest Haskell implementation ran in ~35 ms, much slower than my Rust
implementation. I decided to ask in the haskell irc channel on freenode if
anyone had a faster implementation.

dwins in the Haskell IRC suggested I replace `filter even [0 .. x]` with
`[0, 2 .. x]`. This significantly speeds up the execution time on my machine to
~10 ms.
