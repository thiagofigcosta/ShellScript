#!/bin/bash
printf "O maior numero é o: "
printf "%s\n" $@ | sort -n | tail --lines=1