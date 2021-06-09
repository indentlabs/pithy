# pithy
Text compression

## Files

pithy-key.rb - Generate an optimized pithy key for a file

pithy.rb - Compress a file given a pithy key

depithy.rb - Decompress a file given a pithy key

## Example compression --> decompression lifecycle

1. Generate a domain-specific compression key

    $ ./pithy-key.rb books/aliceinwonderland.txt -o lewiscarroll.pith
    Key file saved to ./lewiscarroll.pith

2. Compress a document with that key

    $ ./pithy.rb books/aliceinwonderland.txt -k lewiscarroll.pith -o minified-aiw.txt
    File books/aliceinwonderland.txt is now pithy! Minified version saved to minified-aiw.txt
    Original filesize: 151079
    New filesize:      35481
    Decreased by       115598 (~76% reduction)

    To depithify it, don't forget you will need lewiscarroll.pith!
    $ ./depithy minified-aiw.txt -k lewiscarroll.pith

3. Send your much-tinier file wherever you want!

    $ head -n 5 minified-aiw.txt

4. Decompress the file back to its original

    $ ./depithy.rb -k lewiscarroll.pith minified-aiw.txt -o original-aiw.txt
    File minified-aiw.txt is no longer pithy! Bigified version saved to original-aiw.txt
    Original filesize: 35481
    New filesize:      34106
    Increased by       -1375 (~-3% increase)