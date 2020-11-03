#!/bin/bash 

binary_search() {
    to_find=$1
    shift
    sorted_array=("$@")
    low=0
    high="$((${#sorted_array[@]}-1))"
    while [ $low -le $high ] ; do
        mid="$(( ($low+$high)/2 ))"
        mid=${mid%.*}
        if [ $to_find -lt ${sorted_array[mid]} ]; then
            high="$((mid-1))"
        elif [ $to_find -gt ${sorted_array[mid]} ]; then
            low="$((mid+1))"
        else
            found_idx=$mid
            return
        fi
    done
    found_idx=-1
}

array=(1 2 4 8 16 32 64 128)
search=128

binary_search $search ${array[@]}
echo "Array: ${array[@]}"
if [ $found_idx -ge "0" ]; then
    echo "Found $search on index $found_idx"
    array=( "${array[@]:0:$((found_idx))}" "${array[@]:$((found_idx+1))}" )
else
    echo "Not found $search"
fi
echo "Array w/o el: ${array[@]}"