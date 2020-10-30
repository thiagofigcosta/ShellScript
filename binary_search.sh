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
        if [[ $to_find < ${sorted_array[mid]} ]]; then
            high="$(($mid-1))"
        elif [[ $to_find > ${sorted_array[mid]} ]]; then
            low="$(($mid+1))"
        else
            found_idx=$mid
            return
        fi
    done
    found_idx=-1
}

array=(1 2 4 8 16 32 64 128)
search=4

binary_search $search ${array[@]}
echo $found_idx