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
time                 35.12 μs   (34.90 μs .. 35.30 μs)
                     1.000 R²   (1.000 R² .. 1.000 R²)
mean                 35.25 μs   (35.14 μs .. 35.37 μs)
std dev              382.6 ns   (332.6 ns .. 447.9 ns)

benchmarking fun1/1000000
time                 35.14 ms   (34.47 ms .. 35.66 ms)
                     0.999 R²   (0.999 R² .. 1.000 R²)
mean                 34.63 ms   (34.46 ms .. 34.86 ms)
std dev              403.4 μs   (222.1 μs .. 577.7 μs)

benchmarking fun2/1000
time                 38.50 μs   (38.32 μs .. 38.67 μs)
                     1.000 R²   (1.000 R² .. 1.000 R²)
mean                 38.83 μs   (38.65 μs .. 39.05 μs)
std dev              696.1 ns   (550.3 ns .. 968.5 ns)
variance introduced by outliers: 14% (moderately inflated)

benchmarking fun2/1000000
time                 38.55 ms   (38.08 ms .. 38.88 ms)
                     1.000 R²   (0.999 R² .. 1.000 R²)
mean                 38.64 ms   (38.46 ms .. 38.92 ms)
std dev              433.5 μs   (302.3 μs .. 636.3 μs)

benchmarking fun3/1000
time                 10.40 μs   (10.08 μs .. 10.83 μs)
                     0.989 R²   (0.981 R² .. 0.997 R²)
mean                 10.84 μs   (10.45 μs .. 11.63 μs)
std dev              1.925 μs   (1.263 μs .. 2.909 μs)
variance introduced by outliers: 95% (severely inflated)

benchmarking fun3/1000000
time                 10.02 ms   (9.961 ms .. 10.08 ms)
                     1.000 R²   (0.999 R² .. 1.000 R²)
mean                 9.952 ms   (9.909 ms .. 9.994 ms)
std dev              110.4 μs   (91.10 μs .. 139.3 μs)


```
As you can see the Haskell implementation is significantly slower than the Rust
implementation. a list of size 1 million takes around 35 ms with Haskell, whereas
the Rust implementation takes only 500k ns (0.5 ms) on the same machine.

EDIT: dwins in the Haskell IRC suggested I replace `filter even [0 .. x]` with
`[0, 2 .. x]`. This significantly speeds up the execution time on my machine to
~10 ms. Thanks to Cale for the fun4 implementation, which runs in 32.63 ns,
beating the Rust implementation.
