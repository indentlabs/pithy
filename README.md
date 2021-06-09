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
```

**2. Compress a document with that key**

```
$ ./pithy.rb books/aliceinwonderland.txt -k lewiscarroll.pith -o minified-aiw.txt
File books/aliceinwonderland.txt is now pithy! Minified version saved to minified-aiw.txt
Original filesize: 151079
New filesize:      74943
Decreased by       76136 (~50% reduction)

To depithify it, don't forget you will need lewiscarroll.pith!
$ ./depithy minified-aiw.txt -k lewiscarroll.pith
```

**3. Send your much-tinier file wherever you want!**

```
$ tail -n 10 minified-aiw.txt
aON cZ u o aOO aEI a kq b aEJ PH g o 
Rh b bO d C aEK x o bp k mm 
b cd asS dH gV b zq n ge p lN aOP 
da dW n a xR g qM g bB aUs b bO d 
C ju n u W kq aiJ b dk p vl m u 
W kq aOQ Kr o ma Ks b a aOR If 
aOS 

Ri aWa
```

**4. Decompress the file back to its original**

```
$ ./depithy.rb -k lewiscarroll.pith minified-aiw.txt -o original-aiw.txt
File minified-aiw.txt is no longer pithy! Bigified version saved to original-aiw.txt
Original filesize: 74943
New filesize:      152985
Increased by       78042 (~104% increase)
```

## Example filesize reductions for various books

placeholder