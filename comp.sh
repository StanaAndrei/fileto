cd src
ghc --make main.hs
mv main.exe exec.exe
mv exec.exe ..
# rm *.o
# rm *.hi