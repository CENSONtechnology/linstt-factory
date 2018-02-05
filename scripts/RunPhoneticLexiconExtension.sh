#!/bin/bash

. path.sh
. cmd.sh

text_vocab=$1
g2p_model_dir=$2
lexicon_base=$3
name_modif=$4
short_desc=$5

nj=2
cmd=run.pl

output_dir=$lexicon_base$name_modif

# creating the directory and description file
mkdir -p $output_dir
echo $short_desc > $output_dir/description.txt
cp $text_vocab $output_dir/source.txt

# Get additionalTerms
cat $output_dir/source.txt | tr ' ' '\n' | awk 'NR==FNR{a[$1] = 1; next} !($1 in a)' $lexicon_base/lexicon.dict - > $output_dir/additionalTerms.lst

# Add Aditional terms using g2p model
mkdir -p $output_dir/tmp
auto_vocab_prefix="$output_dir/tmp/vocab_autogen"
auto_lexicon_prefix="$output_dir/tmp/lexicon_autogen"

  mkdir -p $output_dir/log
  auto_vocab_splits=$(eval "echo $auto_vocab_prefix.{$(seq -s',' $nj)}")
  cat $output_dir/additionalTerms.lst |\
    sort | tee $output_dir/vocab_autogen.full |\
  utils/split_scp.pl - $auto_vocab_splits
  echo "Autogenerating pronunciations for the words in $auto_vocab_prefix.* ..."
  $cmd JOB=1:$nj $output_dir/log/g2p.JOB.log \
    local/g2p.sh  $auto_vocab_prefix.JOB $g2p_model_dir $auto_lexicon_prefix.JOB
  g2p_vocab_size=$(wc -l < $output_dir/additionalTerms.lst)
  g2p_lex_size=$(wc -l < <(cat $auto_lexicon_prefix.*))
  echo $g2p_vocab_size
  echo $g2p_lex_size
  # TODO Fix problem
  [[ "$g2p_vocab_size" -eq "$g2p_lex_size" ]] || { echo "Unexpected G2P error"; exit 1; }
  sort <(cat $auto_vocab_prefix.*) >$output_dir/vocab_autogen.txt
  sort <(cat $auto_lexicon_prefix.*) >$output_dir/additionalTerms.dict
  echo "$(wc -l <$output_dir/vocab_autogen.full) pronunciations autogenerated OK"

  ####### Merge the previous lexicon and the new terms manually
  cat $output_dir/additionalTerms.dict $lexicon_base/lexicon.dict | sort -u > $output_dir/lexicon.dict
