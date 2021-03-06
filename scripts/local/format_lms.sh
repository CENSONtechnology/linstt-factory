#!/bin/bash

# Copyright 2014 Vassil Panayotov
# Apache 2.0

# Prepares the test time language model(G) transducers
# (adapted from wsj/s5/local/wsj_format_data.sh)

. ./path.sh || exit 1;

# begin configuration section
src_dir=data/lang
# end configuration section

. utils/parse_options.sh || exit 1;

set -e

if [ $# -ne 1 ]; then
  echo "Usage: $0 <lm-dir>"
  echo "e.g.: $0 /export/a15/vpanayotov/data/lm"
  echo ", where:"
  echo "    <lm-dir> is the directory in which the language model is stored/downloaded"
  echo "Options:"
  echo "   --src-dir  <dir>           # source lang directory, default data/lang"
  exit 1
fi

lm_file=$1

if [ ! -f $lm_file ]; then
   echo "$0: expected source LM file $lm_dir to exist"
  exit 1;
fi
if [ ! -f $src_dir/words.txt ]; then
  echo "$0: expected $src_dir/words.txt to exist."
  exit 1;
fi


tmpdir=data/local/lm_tmp.$$
trap "rm -r $tmpdir" EXIT

mkdir -p $tmpdir
filename=$(basename $lm_file)
lm_suffix="${filename%%.*}"
 test=${src_dir}_test_${lm_suffix}
 mkdir -p $test
 cp -r ${src_dir}/* $test
 gunzip -c $lm_file | \
 arpa2fst --disambig-symbol=#0 \
            --read-symbol-table=$test/words.txt - $test/G.fst
 utils/validate_lang.pl --skip-determinization-check $test || exit 1;

echo "Succeeded in formatting data."

exit 0
