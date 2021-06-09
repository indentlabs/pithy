# pithy
Text compression scheme for plaintext/fiction

## Files

pithy-key.rb - Generate an optimized pithy key for a file

pithy.rb - Compress a file given a pithy key

depithy.rb - Decompress a file given a pithy key

## Example compression --> decompression lifecycle

**1. Generate a domain-specific compression key**

```
$ ./pithy-key.rb books/aliceinwonderland.txt -o lewiscarroll.pith
Key file saved to ./lewiscarroll.pith
	Unique words: 5903
	Pithy score: 119082
```

**2. Compress a document with that key**

```
$ ./pithy.rb books/aliceinwonderland.txt -k lewiscarroll.pith -o minified-aiw.txt
File books/aliceinwonderland.txt is now pithy! Minified version saved to minified-aiw.txt
Original filesize: 151079
New filesize:      85488
Decreased by       65591 (~43% reduction)

To depithify it, don't forget you will need lewiscarroll.pith!
$ ./depithy minified-aiw.txt -k lewiscarroll.pith
```

**3. Send your much-tinier file wherever you want!**
```
$ du -h books/aliceinwonderland.txt
148K	books/aliceinwonderland.txt
$ du -h minified-aiw.txt 
84K	minified-aiw.txt
```

```
$ tail -n 10 minified-aiw.txt
bau cV eh dA bav aPh r axF af aPi Ti cR dA
UP af nk aI kc aPj tw dA GU da UQ
af Os aBh NS apz af Aq hh PH bS aoC aPk
cW aRs hh r yK cR UR cR zi bgv af nk aI
kc ji hh eh Je axF aoT af dg bS vP dZ eh
Je axF baw MJ dA lW MK af r bax aNk
aPl

US bij

```

**4. Decompress the file back to its original size and contents**

```
$ ./depithy.rb -k lewiscarroll.pith minified-aiw.txt -o original-aiw.txt
File minified-aiw.txt is no longer pithy! Bigified version saved to original-aiw.txt
Original filesize: 85488
New filesize:      151078
Increased by       65590 (~76% increase)
```

## Example filesize reductions for various books

placeholder