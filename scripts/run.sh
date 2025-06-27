#!/bin/sh
#*=====================================================================*/
#*    serrano/diffusion/article/flt/fst-artifact/scripts/run.sh        */
#*    -------------------------------------------------------------    */
#*    Author      :  Manuel Serrano                                    */
#*    Creation    :  Thu Oct  3 09:44:21 2024                          */
#*    Last change :  Fri Jun 27 15:58:23 2025 (serrano)                */
#*    Copyright   :  2024-25 Manuel Serrano                            */
#*    -------------------------------------------------------------    */
#*    Run all the FLT benchmarks                                       */
#*=====================================================================*/

#*---------------------------------------------------------------------*/
#*    Configuration                                                    */
#*---------------------------------------------------------------------*/
path=`realpath $0`
dir=`dirname $path`

. $dir/env.sh


# output directories
mkdir -p $STATS
mkdir -p $BMEMS
mkdir -p $BRANCHS
mkdir -p $HEAPS
mkdir -p $LOGS

#*---------------------------------------------------------------------*/
#*    benchmark executions                                             */
#*---------------------------------------------------------------------*/
# performance
for bigloo in $BIGLOOS; do
  echo "\e[1;30m=== bglstone ($bigloo)\e[0m"
  conf=`echo $bigloo | sed -e 's/bigloo//'`
  bglstone="bglstone$conf"

  if [ "$conf " = "bigloo " ]; then
    confname=""
  else
    confname=".`echo $bigloo | sed -e 's/bigloo_//'`"
  fi

  if [ ! -f $STATS/$bigloo.stat ]; then
    (cd $downloaddir/$bglstone \
       && make run TARGETS="bigloo" BENCH=$BENCH REPETITION="-r $REPETITION") \
      && cat $downloaddir/$bglstone/src/bigloo.stat \
	| sed -e "s/Bigloo/Bigloo${confname}/" > $STATS/$bigloo.stat
   fi
done

for gambit in $GAMBITS; do
  echo "\e[1;30m=== bglstone ($gambit)\e[0m"
  conf=`echo $gambit | sed -e 's/gambit//'`
  bglstone="bglstone_gambit$conf"

  if [ "$conf " = "gambit " ]; then
    confname=""
  else
    confname=".`echo $gambit | sed -e 's/gambit_//'`"
  fi

  if [ ! -f $STATS/$gambit.stat ]; then
    (cd $downloaddir/$bglstone \
       && make run TARGETS="gambit" BENCH=$BENCH REPETITION="-r $REPETITION") \
      && cat $downloaddir/$bglstone/src/gambit.stat \
	| sed -e "s/Gambit/Gambit${confname}/" \
	      -e "s/gambit/Gambit${confname}/" > $STATS/$gambit.stat
   fi
done

# performance with data on heap
for bigloo in bigloo bigloo_flt1; do
  echo "\e[1;31m=== heap ($bigloo)\e[0m"
  conf=`echo $bigloo | sed -e 's/bigloo//'`
  bglstone="bglstone$conf"
  for benchmark in $SCM_FLOAT_BENCHMARKS; do
    if [ ! -f $HEAPS/$benchmark/$bigloo.heap ]; then
      mkdir -p $HEAPS/$benchmark
      echo "size,time" > $HEAPS/$benchmark/$bigloo.heap.tmp
      for size in $SCM_BENCHMARKS_VECTOR_SIZES; do
        echo "  $benchmark $size"
        printf "$((size * 8))," >> $HEAPS/$benchmark/$bigloo.heap.tmp
        (cd $downloaddir/$bglstone/src/$benchmark/bigloo \
        && BGLSTONE_FILLER="(make-vector $size)" bash -c "time ./bigloo.exe") 2>&1 \
        | fgrep real | sed -e 's/[^0-9]*//' -e 's/m/*60+/' -e 's/s//' | bc >> $HEAPS/$benchmark/$bigloo.heap.tmp
      done
      mv $HEAPS/$benchmark/$bigloo.heap.tmp $HEAPS/$benchmark/$bigloo.heap
    fi
  done
done

for gambit in gambit_0 gambit_1; do
  echo "\e[1;31m=== heap ($gambit)\e[0m"
  conf=`echo $gambit | sed -e 's/gambit//'`
  bglstone="bglstone$conf"
  for benchmark in $SCM_FLOAT_BENCHMARKS; do
    if [ ! -f $HEAPS/$benchmark/$gambit.heap ]; then
      mkdir -p $HEAPS/$benchmark
      echo "size,time" > $HEAPS/$benchmark/$gambit.heap.tmp
      for size in $SCM_BENCHMARKS_VECTOR_SIZES; do
        echo "  $benchmark $size"
        printf "$((size * 8))," >> $HEAPS/$benchmark/$gambit.heap.tmp
        (cd $downloaddir/$bglstone/src/$benchmark/gambit \
        && BGLSTONE_FILLER="(make-vector $size)" bash -c "time ./gambit.exe") 2>&1 \
        | fgrep real | sed -e 's/[^0-9]*//' -e 's/m/*60+/' -e 's/s//' | bc >> $HEAPS/$benchmark/$gambit.heap.tmp
      done
      mv $HEAPS/$benchmark/$gambit.heap.tmp $HEAPS/$benchmark/$gambit.heap
    fi
  done
done

# memory
for bigloo in $BIGLOOS; do
  echo "\e[1;31m=== bmem ($bigloo)\e[0m"
  conf=`echo $bigloo | sed -e 's/bigloo//'`
  bglstone="bglstone$conf"

  for benchmark in $SCM_BENCHMARKS; do
    echo "  $benchmark"
    if [ ! -f $BMEMS/$benchmark/$bigloo.bmem ]; then
      mkdir -p $BMEMS/$benchmark
      (cd $downloaddir/$bglstone/src/$benchmark/bigloo \
	 && $FST_ARTIFACT_ROOT/install/$bigloo/bin/bigloo ${benchmark}.scm -O3 -unsafe -pmem \
	 && BMEMVERBOSE=0 BMEMFORMAT=sexp $FST_ARTIFACT_ROOT/install/$bigloo/bin/bglmemrun ./a.out pmem) \
	&& mv $downloaddir/$bglstone/src/$benchmark/bigloo/a.bmem $BMEMS/$benchmark/$bigloo.bmem
    fi
  done
done

# branch prediction
test_branch_prediction=0;

if [ -f /etc/sysctl.conf ]; then
  paranoid=`cat /etc/sysctl.conf 2> /dev/null | grep kernel.perf_event_paranoid | awk -F= '{print $2}' 2> /dev/null`
  if [ "$paranoid " = "-1 " ]; then
    test_branch_prediction=1;
  elif [ $test_branch_prediction = "0" ]; then
    if [ -f /proc/sys/kernel/perf_event_paranoid ]; then
      paranoid=`cat /proc/sys/kernel/perf_event_paranoid`
      
      if [ $paranoid = "-1" ]; then
	test_branch_prediction=1;
      fi
    fi
  fi
fi

if [ "$test_branch_prediction " = "1 " ]; then
  if which perf > /dev/null 2>&1; then
    for bigloo in $BIGLOOS; do
      echo "\e[1;32m=== branch ($bigloo)\e[0m"
      conf=`echo $bigloo | sed -e 's/bigloo//'`
      bglstone="bglstone$conf"
    
      for benchmark in $SCM_BENCHMARKS; do
        echo "  $benchmark"
        if [ ! -f $BRANCHS/$benchmark/$bigloo.branch ]; then
          mkdir -p $BRANCHS/$benchmark
          (cd $downloaddir/$bglstone/src/$benchmark/bigloo \
    	   && perf stat -x , -e branch-misses ./bigloo.exe 2>&1 > /dev/null | awk -F, '{print $1}' > a.branch) \
    	   && mv $downloaddir/$bglstone/src/$benchmark/bigloo/a.branch $BRANCHS/$benchmark/$bigloo.branch
        fi
      done
    done
  fi
fi

# hop
# echo "\e[1;33m=== jsbench\e[0m"
# conf=`echo $hop | sed -e 's/hop//'`
# confname=`echo $hop | sed -e 's/hop_//'`
# jsbench="jsbench$conf"
# 
# logs=""
# for b in $JS_BENCHMARKS; do
#   logs="$logs $LOGS/$b.log.json"
# done
# 
# if [ ! -f $LOGS/SUMMARY.txt ]; then
#   (cd $downloaddir/$jsbench \
#      && ./hopstone.sh --hopc=$FST_ARTIFACT_ROOT/install/hop/bin/hopc --hop=$FST_ARTIFACT_ROOT/install/hop/bin/hop --dir=$LOGS -e hop -e hop_flt -e hop_nan -e hop_nun -e hop_fltlb -e hop_fltnz -e hop_flt1 octane jetstream sunspider bglstone)
# fi
  
#*---------------------------------------------------------------------*/
#*    last message                                                     */
#*---------------------------------------------------------------------*/
echo "\e[1;29m*** $PLOTDIR\e[0m complete."
