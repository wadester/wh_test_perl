#!/usr/bin/perl 
#
# Module:   daemon.pl
# Purpose:  This module makes a perl daemon
# Author:   Wade Hampton
# Date:     10/9/2015
# Notes:
# 1) Based on tutorial
#
# defaults
my $daemon_home = ".";  # target directory
my $ofile       = "testfile.txt";

# includes
use POSIX qw(setsid);


print "daemon.pl:  test of making a daemon\n";

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

# do work as a daemon

#  while(1) {
#    do work
#  }    

for (my $ii=0; $ii<5; $ii++) {
    printf "%03d Test to stdout\n", $ii;
    printf OF "%03d Test line\n", $ii;
    sleep (1);
}
exit(0);



