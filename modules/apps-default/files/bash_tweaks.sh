alias ll="ls -lhF --color=auto"
alias l.="ls -lhaF --color=auto"
alias l="ls -lhF --color=auto"
alias usage="du -h --max-depth=1"
alias fproc="ps auxw | grep"
alias fc="ls -1 | wc -l"
alias dh="df -h"
alias su="su -l"
alias lsports="netstat -lnptu"
alias flush_ipchains="iptables --policy INPUT ACCEPT;iptables --policy OUTPUT ACCEPT;iptables --flush;iptables --delete-chain"

PS1="\n# \[\e[32;1m\]\d \t\n\]\[\e[0m\]# \[\e[33;1m\]\u @ \h\]\[\e[0m\]\n#
\[\e[35;1m\]\w>\$\[\e[0m\] "