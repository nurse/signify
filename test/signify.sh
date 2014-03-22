#!/bin/sh
#
# $OpenBSD: signify.sh,v 1.7 2014/03/17 15:18:55 tedu Exp $

pubkey="$srcdir/regresskey.pub"
seckey="$srcdir/regresskey.sec"
orders="$srcdir/orders.txt"
forgery="$srcdir/forgery.txt"

if ! sha256 -q $pubkey >/dev/null 2>&1; then
  sha256() {
    if sha256sum $pubkey >/dev/null 2>&1; then
      sha256sum -b $@ | sed -e's/^\([0-9a-f]*\) \*\(.*\)/SHA256 (\2) = \1/'
    elif shasum -a 256 $pubkey >/dev/null 2>&1; then
      shasum -a 256 -b $@ | sed -e's/^\([0-9a-f]*\) \*\(.*\)/SHA256 (\2) = \1/'
    else
      no sha512, sha512sum, or shasum
    fi
  }
fi

if ! sha512 -q $pubkey >/dev/null 2>&1; then
  sha512() {
    if sha512sum $pubkey >/dev/null 2>&1; then
      sha512sum -b $@ | sed -e's/^\([0-9a-f]*\) \*\(.*\)/SHA512 (\2) = \1/'
    elif shasum -a 512 $pubkey >/dev/null 2>&1; then
      shasum -a 512 -b $@ | sed -e's/^\([0-9a-f]*\) \*\(.*\)/SHA512 (\2) = \1/'
    else
      no sha512, sha512sum, or shasum
    fi
  }
fi

set -e

cat $seckey | signify -S -s - -x test.sig -m $orders 
diff -u "$orders.sig" test.sig

signify -V -q -p $pubkey -m $orders

signify -V -q -p $pubkey -m $forgery 2> /dev/null && exit 1

signify -S -s $seckey -x confirmorders.sig -e -m $orders 
signify -V -q -p $pubkey -e -m confirmorders
diff -u $orders confirmorders

sha256 $pubkey $seckey > HASH
sha512 $orders $forgery >> HASH
signify -S -e -s $seckey -m HASH
rm HASH
signify -C -q -p $pubkey -x HASH.sig

rm -f HASH.sig confirmorders confirmorders.sig test.sig
true
