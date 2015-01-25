#!/bin/bash
# copy the source files from a particular version of bytestring,  and
# generate _most_ of the source files by renaming the c functions.

# cbits/fpstring.c still needs some manual work, however.   And this script
# may need to be tweaked to work against future versions of bytestring.

BYTESTRING_VERSION=bytestring-0.10.4.1

rm -rf $BYTESTRING_VERSION

cabal unpack $BYTESTRING_VERSION

gen_file()
{
  echo $1/$2/$3
  mkdir -p $1/$2
  cp -f $BYTESTRING_VERSION/$2/$3 $1/$2/
  sed -i 's/fps_memcpy_offsets/bytestring_builder_memcpy_offsets/g'  $1/$2/$3
  sed -i 's/_hs_bytestring_int_dec/bytestring_builder_int_dec/g' $1/$2/$3
  sed -i 's/_hs_bytestring_long_long_int_dec/bytestring_builder_long_long_int_dec/g' $1/$2/$3
  sed -i 's/_hs_bytestring_uint_dec/bytestring_builder_uint_dec/g' $1/$2/$3
  sed -i 's/_hs_bytestring_long_long_uint_dec/bytestring_builder_long_long_uint_dec/g' $1/$2/$3
  sed -i 's/_hs_bytestring_int_dec_padded9/bytestring_bytestring_int_dec_padded9/g' $1/$2/$3
  sed -i 's/_hs_bytestring_long_long_int_dec_padded18/bytestring_bytestring_long_long_int_dec_padded18/g' $1/$2/$3
  sed -i 's/_hs_bytestring_uint_hex/bytestring_bytestring_uint_hex/g' $1/$2/$3
  sed -i 's/_hs_bytestring_long_long_uint_hex/bytestring_bytestring_long_long_uint_hex/g' $1/$2/$3
  sed -i 's/instance NFData ShortByteString$/instance NFData ShortByteString where rnf !_ = ()/g' $1/$2/$3
}

gen_file .   cbits itoa.c
gen_file src Data/ByteString Builder.hs
gen_file src Data/ByteString/Builder ASCII.hs
gen_file src Data/ByteString/Builder Internal.hs
gen_file src Data/ByteString/Builder Prim.hs
gen_file src Data/ByteString/Builder/Prim/Internal Base16.hs
gen_file src Data/ByteString/Builder/Prim/Internal Floating.hs
gen_file src Data/ByteString/Builder/Prim/Internal UncheckedShifts.hs
gen_file src Data/ByteString/Builder/Prim ASCII.hs
gen_file src Data/ByteString/Builder/Prim Internal.hs
gen_file src Data/ByteString/Builder/Prim Binary.hs
gen_file src Data/ByteString/Builder Extra.hs
gen_file src Data/ByteString Short.hs
gen_file src Data/ByteString/Short Internal.hs
