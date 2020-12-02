#!/bin/bash

start=$(date +%s%3N)

msToHumanReadable() {
  local T=$1
  shift
  local D=$((T/1000/60/60/24))
  local H=$((T/1000/60/60%24))
  local M=$((T/1000/60%60))
  local S=$((T/1000%60))
  local MS=$((T%1000))
  out=""
  (( $D > 0 )) && out=`printf '%s%d days ' "$out" $D`
  (( (( $D > 0 )) && (( $MS == 0 && $S == 0 && $M == 0 && $H > 0 )) )) && out=`printf '%sand ' "$out"`
  (( $H > 0 )) && out=`printf '%s%d hours ' "$out" $H`
  (( (( $D > 0 || $H > 0 )) && (( $MS == 0 && $S == 0 && $M > 0 )) )) && out=`printf '%sand ' "$out"`
  (( $M > 0 )) && out=`printf '%s%d minutes ' "$out" $M`
  (( (( $D > 0 || $H > 0 || $M > 0 )) && (( $MS == 0 && $S > 0 )) )) && out=`printf '%sand ' "$out"`
  (( $S > 0 )) && out=`printf '%s%d seconds ' "$out" $S`
  (( (( $D > 0 || $H > 0 || $M > 0 || $S > 0 )) && $MS > 0 )) && out=`printf '%sand ' "$out"`
  (( $MS > 0 )) && out=`printf '%s%d milliseconds' "$out" $MS`
  out=`printf '%s\n ' "$out"`
}

for i in $(cat /etc/passwd | cut -d':' -f1); do
	sleep 0.5
done


msToHumanReadable $(($(date +%s%3N)-start))

echo Time to run this file: $out