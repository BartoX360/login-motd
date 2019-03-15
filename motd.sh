#!/bin/bash
# Description: MOTD for Debian/Ubuntu
# 2013/07/15 @ysaotome
# 2014/05/29 @frdmn
# 2018/07/17 @Bartox Passage en français + ajout du check de mises à jour disponible

BIN_DATE='/bin/date'
BIN_FIGLET='/usr/bin/figlet'
BIN_HOSTNAME='/bin/hostname'
BIN_IP='/sbin/ip'
BIN_GREP='/bin/grep'
BIN_SED='/bin/sed'
BIN_UPTIME='/usr/bin/uptime'
BIN_CAT='/bin/cat'
BIN_LSB_RELEASE='/usr/bin/lsb_release'
BIN_UNAME='/bin/uname'
BIN_FREE='/usr/bin/free'
BIN_HEAD='/usr/bin/head'
BIN_TAIL='/usr/bin/tail'
BIN_DF='/bin/df'
BIN_AWK='/usr/bin/awk'
BIN_BC='/usr/bin/bc'
BIN_PS='/bin/ps'
BIN_CUT='/usr/bin/cut'
BIN_APT='/usr/bin/aptitude'
BIN_XARGS='/usr/bin/xargs'

COLOR_LIGHT_GREEN='\033[1;32m'
COLOR_LIGHT_BLUE='\033[1;34m'
COLOR_YELLOW='\033[1;33m'
COLOR_RED='\033[0;31m'
COLOR_WHITE='\033[1;37m'
COLOR_DEFAULT='\033[0m'

echo -e "
${COLOR_LIGHT_GREEN}$(${BIN_FIGLET} -ckw 80 -f slant $(${BIN_HOSTNAME} -s))
${COLOR_WHITE}Date et heure                  = ${COLOR_LIGHT_BLUE}$(${BIN_DATE})
${COLOR_WHITE}Hostname                       = ${COLOR_LIGHT_BLUE}$(${BIN_HOSTNAME})
${COLOR_WHITE}Adresse IP                     = ${COLOR_LIGHT_BLUE}$(${BIN_IP} addr show venet0 2>/dev/null | ${BIN_GREP} 'inet ' | ${BIN_SED} -e 's/.*inet \([^ ]*\)\/.*/\1/' | ${BIN_SED} ':a;N;$!ba;s/\n/, /g')
${COLOR_WHITE}Uptime                         = ${COLOR_LIGHT_BLUE}$(${BIN_UPTIME} | ${BIN_CUT} -d "," -f 1 | xargs)
${COLOR_WHITE}Load avg.                      = ${COLOR_LIGHT_BLUE}$(${BIN_UPTIME} | ${BIN_GREP} -o -e "load averages\?.*" | ${BIN_SED} -e "s/load averages\?: //")
${COLOR_WHITE}Release                        = ${COLOR_LIGHT_BLUE}$(${BIN_LSB_RELEASE} -d --short)
${COLOR_WHITE}Mises à jour                   = ${COLOR_LIGHT_BLUE}$(${BIN_APT} search '~U' | wc -l )${COLOR_LIGHT_BLUE}" Mises à jour disponible"
${COLOR_WHITE}Usage CPU                      = ${COLOR_LIGHT_BLUE}$(echo $(${BIN_PS} -eo pcpu | ${BIN_AWK} 'NR>1' | ${BIN_AWK} '{tot=tot+$1} END {print tot}') / $(${BIN_CAT} /proc/cpuinfo | ${BIN_GREP} -c processor) | ${BIN_BC} )%
${COLOR_WHITE}Mémoire        Utilisée/Totale = ${COLOR_LIGHT_BLUE}$(${BIN_FREE} -m | ${BIN_HEAD} -n 2 | ${BIN_TAIL} -n 1 | ${BIN_AWK} {'print $3'})/$(${BIN_FREE} -m | ${BIN_HEAD} -n 2 | ${BIN_TAIL} -n 1 | ${BIN_AWK} {'print $2'})MB
${COLOR_WHITE}Swap           Utilisée/Totale = ${COLOR_LIGHT_BLUE}$(${BIN_FREE} -m | tail -n 1 | ${BIN_AWK} {'print $3'})/$(${BIN_FREE} -m | ${BIN_TAIL} -n 1 | ${BIN_AWK} {'print $2'})MB
${COLOR_WHITE}Disque(/)      Utilisée/Totale = ${COLOR_LIGHT_BLUE}$(${BIN_DF} -h / | tail -n 1 | ${BIN_AWK} {'print $3'})/$(${BIN_DF} -h / | ${BIN_TAIL} -n 1 | ${BIN_AWK} {'print $2'})
${COLOR_RED}#####################
${COLOR_RED}# Commandes utile : #
${COLOR_RED}#####################

${COLOR_WHITE}Purger les simlink orphelins dans /srv/seedbox = ${COLOR_LIGHT_BLUE}purge_simlink
${COLOR_WHITE}Vider le SWAP serveur = ${COLOR_LIGHT_BLUE}vide_swap
${COLOR_DEFAULT}"

unset BIN_DATE BIN_FIGLET BIN_HOSTNAME BIN_IP BIN_GREP BIN_SED BIN_UPTIME BIN_CAT BIN_LSB_RELEASE BIN_UNAME BIN_FREE BIN_HEAD BIN_TAIL BIN_DF BIN_AWK BIN_BC BIN_PS BIN_APT
unset COLOR_LIGHT_GREEN COLOR_LIGHT_BLUE COLOR_YELLOW COLOR_RED COLOR_WHITE COLOR_DEFAULT
