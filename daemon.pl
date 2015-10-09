#!/usr/bin/perl -w
#
# Module:   daemon.pl
# Purpose:  This module makes a perl daemon
# Author:   Wade Hampton
# Date:     10/9/2015
# Notes:
# 1) Based on tutorial
#      Could use Proc::Daemon from CPAN
#        http://search.cpan.org/~akreal/Proc-Daemon-0.21/lib/Proc/Daemon.pod
#      http://perldoc.perl.org/perlfaq8.html
#
# defaults
my $daemon_home = ".";  # target directory, normally "/"
my $ofile       = "testfile.txt";

# includes
use strict;
use POSIX qw(setsid);
use Time::localtime;


print "daemon.pl:  test of making a daemon\n";

# optional:  flush the buffer
$!=1;

# standard is to chdir to / -- alt is to a daemon's home
print "Changing to daemon's dir:  $daemon_home\n";
chdir ($daemon_home);

print "opening test file $ofile\n";
open OF, ">$ofile",       or die "can't open $ofile: $!";

print "re-opening stdin/stdout, this will be the last msg\n";

open STDIN, '/dev/null'   or die "can't read /dev/null: $!";
open STDOUT,'>/dev/null'  or die "can't write /dev/null: $!";
open STDERR,'>/dev/null'  or die "can't write /dev/null: $!";


# fork a child process
defined (my $pid = fork)   or die "can't fork: $!";

# if this is the parent, exit
exit if $pid;

# start new session
setsid                    or die "can't start new sessions: $!";

# reset the umask if desired
umask 0;

# catch signals if needed

# do work as a daemon

# typically, use a while loop
#  while(1) {
#    do work
#  }    

for (my $ii=0; $ii<5; $ii++) {
    my $t = time();
    my $tm = localtime($t);
    printf "%03d %ld %d Test to stdout\n", $ii, $t, $tm->sec;
    printf OF "%03d %ld %d Test line\n", $ii, $t, $tm->sec;
    sleep (1);
}
exit(0);



