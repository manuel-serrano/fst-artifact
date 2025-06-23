#!/bin/sh
#*=====================================================================*/
#*    serrano/diffusion/article/flt/fst-artifact/scripts/env.sh        */
#*    -------------------------------------------------------------    */
#*    Author      :  Manuel Serrano                                    */
#*    Creation    :  Sun Mar 23 08:00:28 2025                          */
#*    Last change :  Mon Jun 23 09:00:51 2025 (serrano)                */
#*    Copyright   :  2025 Manuel Serrano                               */
#*    -------------------------------------------------------------    */
#*    Artifcat environment variables                                   */
#*=====================================================================*/

REPETITION=5
ROOT=${ROOT:-/home/artifact/fst-artifact}
dir=`dirname $path`

host=$FLTHOST

if [ "$host " = " " ]; then
  host=`hostname`
  if [ "$host " = " " ]; then
    host=`uname -n`
    if [ "$host " = " " ]; then
      host=$HOST
      if [ "$host " = " " ]; then
	host=unknown
      fi
    fi
  fi

fi

PLOTDIR=plot.$host

PATH=$PATH:$ROOT/install/bigloo/bin
export PATH

STATS=`dirname $dir`/stats.$host
BMEMS=`dirname $dir`/bmems.$host
BRANCHS=`dirname $dir`/branchs.$host
LOGS=`dirname $dir`/logs.$host

# artifact colors
COLORLB="#54dae5"
COLORFLT="#fa9600"
COLORFLTNZ="#3264c8"
COLORFLTONE="#d83812"
COLORNUN="#109318"
COLORNAN="#edd20b"

# benchmarks
BENCH=r7rs
SCM_BENCHMARKS="r7rs-compiler r7rs-dynamic r7rs-earley r7rs-fibfp r7rs-fft r7rs-graphs r7rs-matrix r7rs-maze r7rs-mbrot r7rs-nboyer r7rs-nucleic r7rs-parsing r7rs-peval r7rs-pnpoly r7rs-ray r7rs-sboyer r7rs-scheme r7rs-simplex r7rs-slatex r7rs-sum1 r7rs-sumfp"
SCM_BENCHMARKS="r7rs-compiler r7rs-dynamic r7rs-earley r7rs-graphs r7rs-matrix r7rs-maze r7rs-nboyer r7rs-parsing r7rs-peval r7rs-sboyer r7rs-scheme r7rs-slatex r7rs-fibfp r7rs-fft r7rs-mbrot r7rs-nucleic r7rs-pnpoly r7rs-ray r7rs-simplex r7rs-sum1 r7rs-sumfp"
JS_BENCHMARKS="bague base64 basic-es2015 boyer boyer-scm crypto  crypto-aes crypto-md5 crypto-sha1 date-format-tofte date-format-xparb deltablue earley earley-boyer earley-scm flightplanner hash-map leval maze puzzle qsort regexp richards sieve sieve-mem splay tagcloud traverse unipoker almabench n-body navier-stokes raytrace"

# compilers
BIGLOOS="bigloo bigloo_flt bigloo_fltv bigloo_fltlb bigloo_fltnz bigloo_flt1 bigloo_nan bigloo_nun"
HOPS="hop hop_flt hop_flt1 hop_fltv"

