# fileto

A simple file utility which enables you to: <br>
-encrypt a file using either an inline key (with Vigener cipher) or a matricial one (with Beaufort cipher) <br>
-the above specified keys can be generated random <br>
-compress a file using huffman compression and optimal binary trees <br>

For the OOP version of the latter check [this](https://github.com/StanaAndrei/huffman-comp).

## Build

Make sure you have haskell and cabal installed. <br>
Run: 
```cabal update``` <br>
```cabal build``` <br> 
```cabal run fileto -- <args> ``` where "args" are the desired arguments
