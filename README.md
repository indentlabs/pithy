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
New filesize:      77966
Decreased by       73113 (~48% reduction)

To depithify it, don't forget you will need lewiscarroll.pith!
$ ./depithy minified-aiw.txt -k lewiscarroll.pith
```

**3. Send your much-tinier file wherever you want!**
```
$ du -h books/aliceinwonderland.txt
148K	books/aliceinwonderland.txt
$ du -h minified-aiw.txt 
80K	minified-aiw.txt
```

```
$ $ tail -n 10 minified-aiw.txt
Yb ". "n "M Yc SS 2 Iy Z ST 9: "* "M
:0 Z 'j w &% SU +2 "M 2U "3 :1
Z 6] Ks 6C EO Z .{ $L 7A !V D} SV
"/ Tg $L 2 .' "* :2 "* .? \~ Z 'j w
&% %V $L "n 3h Iy E/ Z "9 !V ,N "f "n
3h Iy Yd 5e "M '( 5f Z 2 Ye RM
SW

:3 ]{
```

**4. Decompress the file back to its original size and contents**

```
$ ./depithy.rb -k lewiscarroll.pith minified-aiw.txt -o original-aiw.txt
File minified-aiw.txt is no longer pithy! Bigified version saved to original-aiw.txt
Original filesize: 77966
New filesize:      151078
Increased by       73112 (~93% increase)
```

## Example filesize reductions for various books

placeholder