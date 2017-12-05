# logger.sh
Generic bash logger functions

## Usage
- log "message"  //log message
- info "message" //info message
- warn "message" //warning message
- err "message"  //error message
- dbg "message"  //debug message

## Important
make sure to have the following lines at beginning of the caller script:

```` bash
PROG=` basename $0 `
source $HOME/bin/logger.sh $PROG &>/dev/null ; ret=$?
if [[ $ret -eq 1 ]] ; then
  echo "$HOME/bin/logger.sh not found. Exiting." ; exit $ret
fi
````

##### Note 1: Logging to database,
```` bash
## Uncomment body of function if you want to log to DB
## if you do not want do log to DB, comment the body and
## add a ":" (null command)
## see http://tldp.org/LDP/abs/html/functions.html#EMPTYFUNC
function logToDB() {
  LOGUSER='-uroot'
  LOGPASS='-ppassword'
  LOGDB='log_db'
  log_db="mysql $LOGUSER $LOGPASS $LOGDB -A -e"
  $log_db "$1"
  # :
}
````

##### Note 2: to write to log file,
```` bash
caller_program.sh >>caller_program.log 2>&1
````
