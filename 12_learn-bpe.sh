#!/bin/bash

##  Eryk Wdowiak
##  09 Sept 2020

##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##

##  Byte-Pair Encoding with Sennrich et al's "subword-nmt"
##    *  https://github.com/rsennrich/subword-nmt

##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##

NUM_OP=3000
VCB_TH=5

CODES="dataset/judge-1377884607_yy_subwords.en"
VOCAB="dataset/judge-1377884607_yy_vocab-bpe.en"

TRAIN_ORIG="dataset/judge-1377884607_zz_tweets-train_v0.txt"
TEST_ORIG="dataset/judge-1377884607_zz_tweets-test_v0.txt"

TRAIN_SED="dataset/judge-1377884607_zz_tweets-train_v1-sed.txt"
TEST_SED="dataset/judge-1377884607_zz_tweets-test_v1-sed.txt"

TRAIN_BPE="dataset/judge-1377884607_zz_tweets-train_v2-bpe.txt"
TEST_BPE="dataset/judge-1377884607_zz_tweets-test_v2-bpe.txt"

##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##

sed 's/^"//;s/"$//;s/\s\+/ /g' $TRAIN_ORIG > $TRAIN_SED
sed 's/^"//;s/"$//;s/\s\+/ /g' $TEST_ORIG  > $TEST_SED

##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##

subword-nmt learn-bpe -s $NUM_OP < $TRAIN_SED > $CODES

subword-nmt apply-bpe -c $CODES  < $TRAIN_SED | subword-nmt get-vocab > $VOCAB

subword-nmt apply-bpe -c $CODES --vocabulary $VOCAB --vocabulary-threshold $VCB_TH < $TRAIN_SED | sed 's/^/"/;s/$/"/' > $TRAIN_BPE
subword-nmt apply-bpe -c $CODES --vocabulary $VOCAB --vocabulary-threshold $VCB_TH < $TEST_SED  | sed 's/^/"/;s/$/"/' > $TEST_BPE
