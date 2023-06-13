#!/bin/bash

##########################################################################################################################
#
# Argument parser for shell script, bellow some dummy arguments as example
#
# version: 1.0.0
#
# Options (* means mandatory) (# -> has flag value):
#   -I / --int                      *# Example integer arg
#   -F / --float                    *# Example float arg
#   -D                              # Example integer arg with default value: 13
#   -B / --bool                     Example bool arg
#   --dont-run-ls-home              Another bool flag
#   --custom-cat-path [path]        #File path to run `cat`, i.e., string arg example 
#   --custom-ls-paths [path]        #File paths to run `ls`, i.e., string array arg example 
#                                    paths should be splitted by comma (,)
# e.g.
# ./argument_parser.sh -I 10 --float 10.23 -D 2 --custom-ls-paths /var,/etc --custom-cat-path /proc/cpuinfo # OK
# ./argument_parser.sh -I 10 --float 10.23      # OK
# ./argument_parser.sh -I 10 --float            # FAIL
# ./argument_parser.sh -I 10                    # FAIL
# ./argument_parser.sh -I 10  -F oi             # FAIL
# ./argument_parser.sh -I 10.1 -F 1             # FAIL
##########################################################################################################################


## Argument variables
ARG__INT_VAL=""
ARG__FLOAT_VAL=""
ARG__D_VAL=13
ARG__BOOL_VAL=false
ARG__RUN_LS_HOME_VAL=true
ARG__CUSTOM_CAT_PATH=""
ARG__CUSTOM_LS_PATHS=()
declare -a ARG__CUSTOM_LS_PATHS
## Argument variables


## Logger stuff
LOGS_PERSISTANCE_DAYS=10
LOGS_PATH="argument_parser_logs/"

log_prefix() {
  echo "[`date +"%F %T"`][$HOSTNAME]" 
} 

log_info() {
	echo $(log_prefix) "$1" | tee -a "$LOG_FILE"
}

log_clean() {
	echo "$1" | tee -a "$LOG_FILE"
}

log_error() {
	echo $(log_prefix) "$1" | >&2 tee -a "$LOG_FILE"
}

log_fatal() {
	log_error "$1"
    exit 1
}

[ ! -d $LOGS_PATH ] && mkdir -p $LOGS_PATH
LOG_FILE="${LOGS_PATH}$(date '+%Y%m%d.log')"

write_test_file="${LOGS_PATH}write_test.$(date '+%Y%m%d')"
touch $write_test_file
if [ $? -ne 0 ] ; then
    echo "Not enough permission to log at $LOGS_PATH!"
    exit 1
else
    rm -f $write_test_file
fi
## Logger stuff


## Parsing args
while [ $# -gt 0 ] ; do
  case $1 in

    -I | --int) 
        if ! [[ $2 =~ ^[0-9]+$ ]]; then
            log_fatal "Option $1 value must be an integer. Provided: $2."
        fi
        ARG__INT_VAL="$2"
        shift 2 # shift twice, for argument and value
    ;;


    -F | --float) 
        if ! [[ $2 =~ ^[0-9\.]+$ ]]; then
            log_fatal "Option $1 value must be a float. Provided: $2."
        fi
        ARG__FLOAT_VAL="$2"
        shift 2 # shift twice, for argument and value
    ;;


    -D) 
        if ! [[ $2 =~ ^[0-9]+$ ]]; then
            log_fatal "Option $1 value must be an integer. Provided: $2."
        fi
        ARG__D_VAL="$2"
        shift 2 # shift twice, for argument and value
    ;;


    -B | --bool | --boolean) 
        if ! [[ $2 =~ ^[0-9]+$ ]]; then
            log_fatal "Option $1 value must be an integer. Provided: $2."
        fi
        ARG__BOOL_VAL=true
        shift # shift once, for argument
    ;;


    --dont-run-ls-home) 
        ARG__RUN_LS_HOME_VAL=`! $ARG__RUN_LS_HOME_VAL`
        shift # shift once, for argument
    ;;


    --custom-cat-path) 
        if  [ ! -f $2 ]; then
            log_fatal "Option $1 value must be a valid file. Provided: $2."
        fi
        ARG__CUSTOM_CAT_PATH="$2" 
        shift 2 # shift twice, for argument and value
    ;;


    --custom-ls-paths) 
        IFS=', ' read -r -a ARG__CUSTOM_LS_PATHS <<< "$2"
        for (( i=0; i<${#ARG__CUSTOM_LS_PATHS[@]}; i++ ));
        do
            if  [ ! -d ${ARG__CUSTOM_LS_PATHS[$i]} ]; then
                log_fatal "Value ${ARG__CUSTOM_LS_PATHS[$i]} must be a valid folder."
            fi
        done
        shift 2 # shift twice, for argument and value
    ;;


    *)
    log_fatal "Unknow argument error. Option $1 with value $2."
    ;;
  esac
done
## Parsing args


## CHECK FOR MANDATORY ARGUMENTS
if [ -z "$ARG__INT_VAL" ]; then
  log_fatal "Provide the mandatory argument --int."
fi

if [ -z "$ARG__FLOAT_VAL" ]; then
  log_fatal "Provide the mandatory argument --float."
fi
## CHECK FOR MANDATORY ARGUMENTS


log_info "Argument parser parsed args successfully!"

log_info "Int value is: $ARG__INT_VAL"
log_info "Float value is: $ARG__FLOAT_VAL"
log_info "D int value with default as 13 is: $ARG__D_VAL"

if $ARG__BOOL_VAL; then
    log_info "The boolean flag --bool (or alias) was provided!"
else
    log_error "Unfortunately the boolean flag --bool (or alias) was NOT provided!"
fi
 
if $ARG__RUN_LS_HOME_VAL; then
    log_info "Running ls at home!"
    ls $HOME
fi

if [ ! -z "$ARG__CUSTOM_CAT_PATH" ]; then
    log_info "Running cat $ARG__CUSTOM_CAT_PATH!"
    cat $ARG__CUSTOM_CAT_PATH
fi


if [ "${#ARG__CUSTOM_LS_PATHS[@]}" -gt 0 ]; then
    log_info "Running ls at custom locations!"
    for (( i=0; i<${#ARG__CUSTOM_LS_PATHS[@]}; i++ ));
    do
        log_info "Running: ls ${ARG__CUSTOM_LS_PATHS[$i]}"
        ls "${ARG__CUSTOM_LS_PATHS[$i]}"
    done
fi


# delete log files older than logs_validity days
find $LOGS_PATH -type f -mtime +$LOGS_PERSISTANCE_DAYS -name '*.log' -execdir rm -- '{}' \;
