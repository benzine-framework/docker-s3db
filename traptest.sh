#!/bin/bash
# traptest.sh
# Define shutdown + cleanup procedure
cleanup() {
    echo "Container stop requested, running final dump + cleanup"
    echo "Good bye!"
}

# Trap SIGTERM
echo "Setting SIGTERM trap"
trap 'cleanup' EXIT SIGINT
trap 'echo SIGQUIT' SIGQUIT

# Trap SIGTERM
#echo "Setting SIGTERM trap"
#trap 'echo "Hello!"' SIGABRT SIGALRM SIGBUS SIGCHLD SIGCONT SIGFPE SIGHUP SIGILL SIGINT SIGIO SIGPIPE SIGPROF SIGPWR SIGQUIT SIGSEGV SIGSTKFLT SIGSTOP SIGTSTP SIGSYS SIGTERM SIGTRAP SIGTTIN SIGTTOU SIGURG SIGUSR1 SIGUSR2 SIGVTALRM SIGXCPU SIGXFSZ SIGWINCH
#trap 'cleanup' EXIT
#trap 'echo  SIGABRT'  SIGABRT
#trap 'echo  SIGALRM'  SIGALRM
#trap 'echo  SIGBUS'  SIGBUS
#trap 'echo  SIGCHLD'  SIGCHLD
#trap 'echo  SIGCONT'  SIGCONT
#trap 'echo  SIGFPE'  SIGFPE
#trap 'echo  SIGHUP'  SIGHUP
#trap 'echo  SIGILL'  SIGILL
#trap 'echo  SIGINT'  SIGINT
#trap 'echo  SIGIO'  SIGIO
#trap 'echo  SIGPIPE'  SIGPIPE
#trap 'echo  SIGPROF'  SIGPROF
#trap 'echo  SIGPWR'  SIGPWR
#trap 'echo  SIGQUIT'  SIGQUIT
#trap 'echo  SIGSEGV'  SIGSEGV
#trap 'echo  SIGSTKFLT'  SIGSTKFLT
#trap 'echo  SIGSTOP'  SIGSTOP
#trap 'echo  SIGTSTP'  SIGTSTP
#trap 'echo  SIGSYS'  SIGSYS
#trap 'echo  SIGTERM'  SIGTERM
#trap 'echo  SIGTRAP'  SIGTRAP
#trap 'echo  SIGTTIN'  SIGTTIN
#trap 'echo  SIGTTOU'  SIGTTOU
#trap 'echo  SIGURG'  SIGURG
#trap 'echo  SIGUSR1'  SIGUSR1
#trap 'echo  SIGUSR2'  SIGUSR2
#trap 'echo  SIGVTALRM'  SIGVTALRM
#trap 'echo  SIGXCPU'  SIGXCPU
#trap 'echo  SIGXFSZ'  SIGXFSZ
#trap 'echo  SIGWINCH'  SIGWINCH

echo "pid is $$"

while :			# This is the same as "while true".
do
  echo "Idling"
  sleep 60	# This script is not really doing anything.
done
