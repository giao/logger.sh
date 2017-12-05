#!/bin/bash

######################################################################
#
# Description: Generic logger functions
# Author: giao@etancesys.com
# LastModif: 2017-12-04 22:45
#
# Usage:
#   - log "message"  //log message
#   - info "message" //info message
#   - warn "message" //warning message
#   - err "message"  //error message
#   - dbg "message"  //debug message
#
# Important:
#   make sure to have the following lines at beginning of the caller script:
#
#   PROG=` basename $0 `
#   source $HOME/bin/logger.sh $PROG &>/dev/null ; ret=$?
#   if [[ $ret -eq 1 ]] ; then
#     echo "$HOME/bin/loggerAAAAA.sh not found. Exiting." ; exit $ret
#   fi
#
#
# Note 1: uncomment body of logToDB() if you want to log do database
#
# Note 2: to write to log file,
#    caller_program.sh >>caller_program.log 2>&1
#
####################################################################

## PROG is caller program
PROG=$1

## Uncomment body of function if you want to log to DB
## if you do not want do log to DB, comment the body and
## add a ":" (null command)
## see http://tldp.org/LDP/abs/html/functions.html#EMPTYFUNC
function logToDB() {
  #LOGUSER=''
  #LOGPASS=''
  #LOGDB=''
  #log_db="mysql $LOGUSER $LOGPASS $LOGDB -A -e"
  #$log_db "$1"
  :
}

function log() {
  DT=` date +'%Y-%m-%d %H:%M:%S'`
  case $1 in
  'INFO')
    LVL='INFO'
    MSG="${@:2}"
    ;;
  'WARN')
    LVL='WARN'
    MSG="${@:2}"
    ;;
  'ERR' | 'ERROR')
    LVL='ERROR'
    MSG="${@:2}"
    ;;
  'DBG' | 'DEBUG')
    LVL='DEBUG'
    MSG="${@:2}"
    ;;
  'LOG')
    LVL='LOG'
    MSG="${@:2}"
    ;;
  *)
    LVL='LOG'
    MSG="$*"
    ;;
  esac

  if [ "A$PROG" == "A" ] ; then
    echo -e "$DT\t$LVL\t$MSG"
    logToDB "insert into logs (ts,prog,errtype,msg) values ('$DT','','$LVL','$MSG');"
  else
    echo -e "$DT\t$LVL\t$PROG\t$MSG"
    logToDB "insert into logs (ts,prog,errtype,msg) values ('$DT','$PROG','$LVL','$MSG');"
  fi
}

function info() {
  log INFO $*
}
function warn() {
  log WARN $*
}
function err() {
  log ERROR $*
}
function error() {
    log ERROR $*
}
function dbg() {
  log DEBUG $*
}

function debug() {
  log DEBUG $*
}
