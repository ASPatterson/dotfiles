#PS1 and aa_prompt_defaults
#https://www.askapache.com/linux/bash-power-prompt/

cd /home/user/
# man for the common man: https://tldr.ostera.io/

###
# FOR without do/done
#for i in {1..10};{ echo "$i";}
#for((i=0;i<=10;i++)); do echo "$i"; done
# DATE without date
#date "+%a %d %b  - %l:%M %p"
#printf "%(%a %d %b  - %l:%M %p)T\\n"
#printf -v date "%(%a %d %b  - %l:%M %p)T\\n"
###


# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#prompt string
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
#OLD PS1="\[\033[01;34m\][\t]\[\e[0m\] \[\033[00;34m\][\u@\h]\[\e[0m\] \w \[\033[01;32m\]> \[\e[0m\] "
#PS1="\[\033[01;34m\][\t]\[\e[0m\] \[\033[00;34m\][\u@\h]\[\e[0m\] \w\[\e[0m\]\[\033[33m\]\$(parse_git_branch)\[\033[00m\]\[\033[01;32m\]> \[\e[0m\]"
#PS1="\[\033[01;34m\][\t]\[\e[0m\] \[\033[01;34m\][\u@\h]\[\e[0m\] \w\[\e[0m\]\[\033[33m\]\$(parse_git_branch)\[\033[00m\]\[\033[01;32m\]> \[\e[0m\]"
#PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "
PS1="\n\[\e[1;30m\][$$:$PPID - \j:\!\[\e[1;30m\]]\[\e[0;36m\] \T \[\e[1;30m\][\[\e[1;34m\]\u@\H\[\e[1;30m\]:\[\e[0;37m\]${SSH_TTY:-o} \[\e[0;32m\]+${SHLVL}\[\e[1;30m\]] \[\e[1;37m\]\w\[\e[0;37m\] \n\$ "

#if [ -n "$PS1" ]; then # if statement guards adding these helpers for non-interative shells
#  eval "$(~/base16-shell/profile_helper.sh)"
#fi

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
alias killport='sudo kill $(sudo lsof -t -i:5000)'

# images
# find *.JPG -exec convert {} -resize 800x600\> {} \;
function resizejpg {
    convert $1 -resize 800x600\> $2
}

# ll, dir, etc
alias grep='grep --color=always'
function grepcolor {
    grep --color -E "$1|$" $2 # keeps non-matching lines
}
# prints dirs in which file extension $1 reside
function inwhichdir {
    find . -name "*.$1" | sed 's/\/[^\/]*$//' | sort | uniq
}
alias less='less --RAW-CONTROL-CHARS'
export LS_OPTS='--color=auto' #--color=never
alias ls='ls ${LS_OPTS}'
alias ll='ls -larth'
alias lsd='ls -d */'
#alias countdirs='find . -maxdepth 1 -type d -print0 | xargs -0 -I {} sh -c 'echo -e $(find "{}" -printf "\n" | wc -l) "{}"' | sort -n'
alias n='nano' # -m for mouse mode
alias rl='root -l'
function cl(){ cd "$@" && ls -lrth; }
function diffdir(){ diff -rq "$1" "$2"; }
alias ..="cd .."
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../.."
alias ..5="cd ../../../../.."
alias fuck='sudo $(history -p \!\!)'
alias ex='exit'
alias gtop='nodejs /usr/local/bin/gtop' #sort by p, c, m for pid, cpu, mem
#alias robustsshfs='sshfs -o reconnect,ServerAliveInterval=15,ServerAliveCountMax=3,IdentityFile=/home/me/.ssh/id_rsa user@server:/home/user/dir dirshare/'


# passy
alias rand64='openssl rand -base64 15'
alias randhex='openssl rand -hex 16'

# images
alias getimagesize='identify -format "%w%h"'
# resize: convert image.jpg -resize 800x600\> image-small.jpg

# misc
alias parrot='curl parrot.live'
alias date='date --iso-8601' #--iso-8601=ns' #Year Month Day Hour Minute Secon Nanosecond Timezone
#alias dt='date "+%F %T"'
alias yt='youtube-dl'
alias ytm='youtube-dl --extract-audio --audio-format mp3'
alias whichpackage='apt-file search' # dpkg -S <file>
alias wrap='fmt -w 80 <<<'
alias gpg='gpg --keyid-format LONG'
alias base64d='base64 -d <<< '
alias base64e='base64 <<< '
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
alias forgotctrl='echo -e "\n Ctrl+A jump to start, E to end; W to wipe arg, K to wipe after cursor, U to wipe before. \n"'
alias red='rtv --enable-media'
alias spooky='play -n synth sin 900 bend 0.3,800,1 bend 1.2,-150,1 trim 0 3.5 reverb -w'
alias longline='awk '"'"'length>m{delete a;a[$0]=0;m=length}length==m{a[$0]=0}END{for(i in a)print i}'"'"
#printf "aa\nbb\ncc\n" | longline -
alias makeoneline='tr "\n\r" " " <'
alias whatsup='sudo fatrace'
alias obj='objdump -Mintel -F -d'
alias hyperspace='ssh -J user1@host1 user2@host2' # ProxyCommand is pre-17.04 way
alias greplinks='sed -n '"'"'s/.*href="\([^"]*\).*/\1/p'"'"
alias forfile='while read p; do echo $p; done <'
alias aslr='bash -c '"'"'grep heap /proc/$$/maps'"'"
alias letitsnow='clear;while :;do echo $LINES $COLUMNS $(($RANDOM%$COLUMNS));sleep 0.1;done|gawk '"'"'{a[$3]=0;for(x in a) {o=a[x];a[x]=a[x]+1;printf "\033[%s;%sH ",o,x;printf "\033[%s;%sH*\033[0;0H",a[x],x;}}'"'"

# exif tools. extract useful info recursively, build into csv.
#pdf# exiftool -csv -title -author -creator -creatortool -pagecount -pdfversion -createdate -r -ext pdf . > exifdata.csv
#docx# exiftool -csv -title -creator -lastmodifiedby -company -application -template -words -appversion -docsecurity -createdate -r -ext  docx . > exif-docx.csv
#ppt# exiftool -csv -title -titleofparts -currentuser -author -lastmodifiedby -company -software -codepage -words -notes -appversion -createdate -r -ext ppt . > exif-ppt.csv
#general# exiftool -a -u -g2 -s <file.type>

## PRETTYPRINT JSON
alias prettyprint='python -m json.tool <<< '
# OR use jq. bao (be aware of) --sort-keys. works with curl.
# alias prettyprint='jq . <<< '
# OR use fxns
#prettyjson_s() {
#    echo "$1" | python -m json.tool
#}
#prettyjson_f() {
#    python -m json.tool "$1"
#}
#prettyjson_w() {
#    curl "$1" | python -m json.tool
#}


listlarge () {
  find $1 -type f -exec du -Sh {} + | sort -rh | head -n 10
}

# exec
#source ~/root/bin/thisroot.sh

htd () {
  printf "%d\n" $1 # depends on 0x prefix
  # echo $(($1)) # depends on 0x prefix
  # echo $((16#$1)) # depends on no prefix
  # echo "ibase=16; $1" | bc # depends on no prefix
  # python -c 'print(int("$1",16))' # broken ticks
}
dth () {
  printf "0x%x\n" $1
}
# complex math - use dc
# dc -e '16i FF 01 - p 10o p'

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

trim() {
    set -f
    set -- $*
    printf "%s\\n" "$*"
    set +f
}

function hdspeed
{
  hdparm -tT /dev/sda
  hdparm -l /dev/sda | grep -i speed
  dmesg | grep -i sata | grep 'link up'
}
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

rainymood() {
  FILE=$((RANDOM%4))
  URL="https://rainymood.com/audio1110/${FILE}.ogg"
  mpv "$URL" && rainymood
}

# added by Anaconda3 installer
export PATH="/home/user/anaconda3/bin:$PATH"

if [ -f $HOME/bash-insulter/src/bash.command-not-found ]; then
    source $HOME/bash-insulter/src/bash.command-not-found
fi


###
function aa_prompt_defaults ()
{
   local colors=`tput colors 2>/dev/null||echo -n 1` C=;

   if [[ $colors -ge 256 ]]; then
      C="`tput setaf 33 2>/dev/null`";
      AA_P='mf=x mt=x n=0; while [[ $n < 1 ]];do read a mt a; read a mf a; (( n++ )); done</proc/meminfo; export AA_PP="\033[38;5;2m"$((mf/1024))/"\033[38;5;89m"$((mt/1024))MB; unset -v mf mt n a';
   else
      C="`tput setaf 4 2>/dev/null`";
      AA_P='mf=x mt=x n=0; while [[ $n < 1 ]];do read a mt a; read a mf a; (( n++ )); done</proc/meminfo; export AA_PP="\033[92m"$((mf/1024))/"\033[32m"$((mt/1024))MB; unset -v mf mt n a';
   fi;

   eval $AA_P; 

   PROMPT_COMMAND='stty echo; history -a; echo -en "\e[34h\e[?25h"; (($SECONDS % 2==0 )) && eval $AA_P; echo -en "$AA_PP";';
   SSH_TTY=${SSH_TTY:-`tty 2>/dev/null||readlink /proc/$$/fd/0 2>/dev/null`}

   PS1="\[\e[m\n\e[1;30m\][\$\$:\$PPID \j:\!\[\e[1;30m\]]\[\e[0;36m\] \T \d \[\e[1;30m\][${C}\u@\H\[\e[1;30m\]:\[\e[0;37m\]${SSH_TTY/\/dev\/} \[\e[0;32m\]+${SHLVL}\[\e[1;30m\]] \[\e[1;37m\]\w\[\e[0;37m\]\n\\$ ";

   export PS1 AA_P PROMPT_COMMAND SSH_TTY
}
aa_prompt_defaults
