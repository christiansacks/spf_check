#!/bin/bash
usage() {
  echo "Usage: $(basename $0) {domain.tld} {debug}        | debug is optional, accepts true/yes/1 for true and false/no/0 for false (or just don't use)"
  exit 1
}
[[ $# -gt 0 ]] && DOMAIN=$1 || usage
case $2 in
  [yY][eE][sS]|[tT][rR][uU][eE]|1) DEBUG=true;;
esac
COUNT=0
DEPTH=0
mDEPTH=0
INDENT=2
checkIncludes() {
  SPF=$1
  for I in $(dig -t txt $SPF +short|grep -oE "include:.* |ip[4,6]:.* "|sed 's/include://g; s/ip[4,6]://g; s/\"//g'|tr ' ' '\n'); do
    [[ $DEBUG ]] && printf "%*s%s %s\n" $(($DEPTH*$INDENT)) '' "$I"
    if [[ ! ${I} =~ ^[0-9] ]]; then
      DEPTH=$(($DEPTH+1))
      mDEPTH=$(($mDEPTH+1))
      checkIncludes $I
    fi
    COUNT=$(($COUNT+1))
  done
  DEPTH=$(($DEPTH-1))
}
checkIncludes $DOMAIN
[[ $DEBUG ]] && echo
echo "Total: $COUNT (Max lookups: $mDEPTH)"
