# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1="\[\033[01;34m\][\t]\[\e[0m\] \[\033[00;34m\][\u@\h]\[\e[0m\] \w \[\033[01;32m\]> \[\e[0m\] "

# history
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000
#PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ; }"'echo `dt` `pwd` $$ $USER \
#               "$(history 1)" >> ~/.bash_eternal_history'

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# close output file descriptor 0, killing shell
alias killthis='exec 0>&-'
alias killjobs='kill -KILL $(jobs -p)'

# ll, dir, etc
alias less='less --RAW-CONTROL-CHARS'
export LS_OPTS='--color=auto' #--color=never
alias ls='ls ${LS_OPTS}'
alias ll='ls -larth'
alias ldd='ls -d */'
#alias countdirs='find . -maxdepth 1 -type d -print0 | xargs -0 -I {} sh -c 'echo -e $(find "{}" -printf "\n" | wc -l) "{}"' | sort -n'
alias n='nano'
alias rl='root -l'
alias dt='date "+%F %T"'
function cl(){ cd "$@" && ls -lrth; }
alias ..="cd .."
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../.."
alias ..5="cd ../../../../.."

# passy
alias randbase64='openssl rand -base64 15'
alias randhex='openssl rand -hex 16'

# misc
#alias bl='xrandr --output DP-0 --brightness'
alias bl='xbacklight -set'
#function dim() {
#    sudo sh -c "echo '$1' >> /sys/class/backlight/acpi_video0/brightness"
#}
alias weather='curl wttr.in'
alias youtube-dl-mp3='youtube-dl --extract-audio --audio-format mp3'
# find executable dirs
alias findexec='find / -type d -perm -o+rwx 2>/dev/null'
alias hoff='unset HISTFILE HISTSIZE HISTFILESIZE'
alias pdftopng='pdftoppm -rx 150 -ry 150 -png'
alias pdftopngall='for i in $(ls *.pdf); do convert -trim -density 150 $i -quality 90 $i.png; done'
alias pdftosvgall='for ii in $(ls *.pdf); do convert $ii $ii.svg; done'
alias compilerbomb="gcc -mcmodel=medium -obomb -xc -<<<main[-1u]={1}\;"
alias scanwifi='sudo iwlist wlp2s0 scan|grep -A5 \(Channel'
alias space='df -h .'
alias chromepdf='google-chrome --headless --disable-gpu --print-to-pdf'
alias chromepng='google-chrome --headless --disable-gpu --screenshot --window-size=1280,1696'
alias forgotctrl='echo -e "\n Ctrl+A jump to start, E to end; K to wipe after cursor, U to wipe before. \n"'

listlarge () {
  find $1 -type f -exec du -Sh {} + | sort -rh | head -n 10
}

# exec
source ~/root/bin/thisroot.sh

go () {
   case "$1" in
     uaf)    dest="apatters@uaf-10.t2.ucsd.edu" ;;
     fnal)   dest="apatters@cmslpc-sl6.fnal.gov" ;;
     server) dest="apatters@ucsbsrv2.cern.ch" ;;
     lxplus) dest="apatters@lxplus.cern.ch" ;;
     slac)   dest="apatters@rhel6-64.slac.stanford.edu" ;;
     *) dest=$1 ;;
   esac
   ssh -Y $dest
}

xf () {
   case "$1" in
     uaf*) src=$(echo $1|sed 's|uaf|apatters@uaf-10.t2.ucsd.edu|') ;;
     fnal*) src=$(echo $1|sed 's|fnal|apatters@cmslpc-sl6.fnal.gov|') ;;
     server*) src=$(echo $1|sed 's|server|apatters@ucsbsrv2.cern.ch|') ;;
     lxplus*) src=$(echo $1|sed 's|lxplus|apatters@lxplus.cern.ch|') ;;
     slac*)   src=$(echo $1|sed 's|slac|apatters@rhel6-64.slac.stanford.edu|') ;;
     *) src=$1 ;;
   esac
   case "$2" in
    uaf*) dest=$(echo $2|sed 's|uaf|apatters@uaf-10.t2.ucsd.edu|') ;;
     fnal*) dest=$(echo $2|sed 's|fnal|apatters@cmslpc-sl6.fnal.gov|') ;;
     server*) dest=$(echo $2|sed 's|server|apatters@ucsbsrv2.cern.ch|') ;;
     lxplus*) dest=$(echo $2|sed 's|lxplus|apatters@lxplus.cern.ch|') ;;
     slac*)   dest=$(echo $2|sed 's|slac|apatters@rhel6-64.slac.stanford.edu|') ;;
     *) dest=$2 ;;
   esac
#  echo $src $dest
   scp $src $dest
}

# colors 
COLOR_SUCCESS="\\033[1;32m"
COLOR_FAILURE="\\033[1;31m"
COLOR_WARNING="\\033[1;33m"
COLOR_NORMAL="\\033[0;39m"
COLOR_NOTE="\\033[0;34m"
SETCOLOR_SUCCESS="echo -en $COLOR_SUCCESS"
SETCOLOR_FAILURE="echo -en $COLOR_FAILURE"
SETCOLOR_WARNING="echo -en $COLOR_WARNING"
SETCOLOR_NORMAL="echo -en $COLOR_NORMAL"
SETCOLOR_NOTE="echo -en $COLOR_NOTE"

function rainbowparty
{
#
#   This file echoes a bunch of color codes to the 
#   terminal to demonstrate what's available.  Each 
#   line is the color code of one forground color,
#   out of 17 (default + 16 escapes), followed by a 
#   test use of that color on all nine background 
#   colors (default + 8 escapes).
#

T='gYw'   # The test text

echo -e "\n                 40m     41m     42m     43m\
     44m     45m     46m     47m";

for FGs in '    m' '   1m' '  30m' '1;30m' '  31m' '1;31m' '  32m' \
           '1;32m' '  33m' '1;33m' '  34m' '1;34m' '  35m' '1;35m' \
           '  36m' '1;36m' '  37m' '1;37m';
  do FG=${FGs// /}
  echo -en " $FGs \033[$FG  $T  "
  for BG in 40m 41m 42m 43m 44m 45m 46m 47m;
    do echo -en "$EINS \033[$FG\033[$BG  $T  \033[0m";
  done
  echo;
done
echo
}
