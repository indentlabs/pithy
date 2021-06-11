# pithy
Text compression scheme for plaintext/fiction

## Example compression --> uncompression lifecycle

**1. Generate a domain-specific compression key**

```
$ ./pithy-key books/aliceinwonderland.txt -o lewiscarroll.pith
Key file saved to ./lewiscarroll.pith
	Unique words: 5903
	Pithy score: 119082
```

**2. Compress a document with that key**

```
$ ./pithy books/aliceinwonderland.txt -k lewiscarroll.pith -o minified-aiw.txt
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

**4. Uncompress the file back to its original size and contents**

```
$ ./depithy -k lewiscarroll.pith minified-aiw.txt -o original-aiw.txt
File minified-aiw.txt is no longer pithy! Bigified version saved to original-aiw.txt
Original filesize: 77966
New filesize:      151078
Increased by       73112 (~93% increase)
```

## Files

### pithy-key

`pithy-key` generates a pithy key (surprise!) tailored to your corpus. It ranks words by `length x frequency`
to determine which words would most benefit from shortening, then outputs those words one-per-line as a key.
Words that are longer and/or used more frequently occur sooner in the pithy key to ensure they get replaced
by the shortest sequences, maximizing space gains in the compressed text.

The ordering of words in this file maps onto the shortword sequence generator and therefore must be used for
both compressing and uncompressing files. 

You'll get the best compression rate by generating a key specific to the text you want to compress, but you
may also choose to compress/uncompress with the generic, standardized keys [provided in this repo](todo) to
minimize the actual amount of data that flies over the wire.

```
pithy-key

  Usage:
    pithy-key books/aliceinwonderland.txt
    pithy-key books/lewiscarroll/*.txt -o lewiscarroll.pith

  Options:
    -o <path/to/file.pith>         Path where the key will be saved
		                               [default: same as txt directory]
```

### pithy

`pithy` compresses a file given a pithy key. Every word in the file is replaced with a shorter sequence of
characters that deterministically maps onto the pithy key's word list. The end result is a lossless,
unreadable document that can be downloaded or transferred faster, that can then be uncompressed back into 
the original text.

```
pithy

  Usage:
    pithy books/aliceinwonderland.txt -k lewiscarroll.pith

  Options:
    -k <path/to/file.pith>         Pith key to use for compression. Required.
    -o <path/to/output.txt>        Path where the compressed text will be saved
		                               [default: same as txt directory]
```

### depithy

`depithy` does the opposite of `pithy`; that is, it uncompresses compressed text. Given a pithy key, it maps
the shortcodes in the text back onto their original words and emits a copy of the original text in its
original size.


```
depithy

  Usage:
    depithy compressed/aliceinwonderland.txt -k lewiscarroll.pith

  Options:
    -k <path/to/file.pith>         Pith key to use for uncompression. Required.
    -o <path/to/output.txt>        Path where the original, uncompressed text will be saved
		                               [default: same as txt directory]
```


## Compression benchmarks for various books

| Book                 | Uncompressed | Pithy w/ key | Pithy with author key | Pithy with stdeng | gzip  |
|----------------------|--------------|--------------|-----------------------|-------------------|-------|
| Alice in Wonderland  |            0 |       0      |       0               |  0                |       |