#!/bin/bash
usage() {
  echo "Usage: $(basename $0) {domain.tld} {debug}        | debug is optional, accepts true/yes/1 for true and false/no/0 for false (or just don't use)"
  exit 1
}
[[ $# -gt 0 ]] && DOMAIN=$1 || usage
case $2 in
  [yY][eE][sS]|[tT][rR][uU][eE]|1) DEBUG=true;;
esac
COUNT=0;DEPTH=0;mDEPTH=0;INDENT=2;
checkIncludes() {
  SPF=$1
  for I in $(dig +short TXT $SPF|grep -oE 'include:[^ ]+|ip[46]:[^ ]+'|sed -E 's/include:|ip[46]:|"//g'); do
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
GRN="[1;32m";YEL="[1;33m";RED="[1;31m";NOCOL="[0m";
case $mDEPTH in
  [0-7])	SCOL="${GRN}";;
  [8-9])	SCOL="${YEL}";;
  *)		SCOL="${RED}";;
esac
echo "${SCOL}Total: $COUNT (Max lookups: $mDEPTH)${NOCOL}"
