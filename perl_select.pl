#!/usr/bin/perl -w
#
# Module:   perl_select.pl
# Purpose:  Perl select and socket 
# Author:   Wade Hampton
# Date:     10/15/2015
# Notes:
# 1) Simple socket setup and select, based on very old test code
#
use warnings;
use strict;

use IO::Select;
use IO::Socket;
use Time::localtime;
use Time::HiRes qw( usleep ualarm gettimeofday tv_interval );

# define the server info
our $port = 9876; # port to listen on
our $lcnt = 5;    # listen count
our %clients;     # hash of client FH data, key is file number

# define select info
our $tmo  = 10;   # select timeout

# command to run when connected
our $cmd  = "date; uname -a";

# telnet command and delay
our $CMD_DELAY=3;
our $TELNET_CMD = "telnet localhost ".$port;

# trap broken pipe messages so we don't die
$SIG{PIPE} = 'IGNORE';

# prototype
sub Now();

# startup msg
my $ts = Now();
printf "perl_select.pl:  select and socket test\n";
printf "%s:  Start, %d port\n", $ts, $port;

# setup STDIN, STDOUT and add STDIN to the socket
STDIN->autoflush(1);
STDOUT->autoflush(1);

# fork a dummy telnet to get the data from the socket
defined (my $pid = fork) or die "can't fork:  $!";

# if this is the child, wait and run a command
if ($pid == 0) {
    sleep($CMD_DELAY);
    print Now().":  CHILD running telnet command\n";
    system($TELNET_CMD);
    exit;
}

# create the socket
my $sckt = new IO::Socket::INET(LocalPort => $port,
				Type      => SOCK_STREAM,
				Reuse     => 1,
				Listen    => $lcnt);

# create the select object with the socket
my $sel = new IO::Select($sckt);

# add STDIN to the select
$sel->add(\*STDIN);

# main loop, loop until done
while(1==1) {
    print Now().":  Waiting...\n";
    my @ready = $sel->can_read($tmo);
    print Now().":  Ready=$#ready\n";
    
    # if ready is -1 we have a timeout
    if ($#ready < 0) {
	print "  timeout\n";
	next;
    }
    
    # process each file 
    foreach my $fh (@ready) {
	my $fn = fileno($fh);  # convert to file descriptor
	
	# if this is from the socket, accept new conn and process
	if ($fh == $sckt) {
	    # accept connection and add to client list
	    my $client = $sckt->accept;
	    $fn = fileno($client);
	    $clients{$fn} = $client;
	    
	    # add the new client to select list and clients list
	    print "  adding $fn ".PortPeer($client)."\n";
	    $sel->add($client);
	    $clients{$fn}=$client;
	    
	    # output data to socket, use client, not $fh -- the socket
	    my $cdata = `$cmd`;
	    syswrite $client, $cdata;
	    syswrite $client, "\r\n";

	    # close socket, remove from select and clients list
	    #shutdown($client, 1);
	    #usleep(1000);
	    $sel->remove($fh);
	    $fh->close;
	    delete $clients{$fn};
	    
	} 
	# if this is from stdin, read data and quit
	elsif ($fh == \*STDIN) {
	    my $indata = <STDIN>;
	    if (defined $indata) {
		print "Read ".$indata."\n";
	    }
	    exit;
	}
	# typically there would be a read from socket here...
	#  else {
	#     read and process socket data -- TBD
	#  }
    }
}

#------------------------------------------------------------------
# PortPeer() -- get port and peer name from file hdl
# - return IP plus port as string:  nn.nn.nn.nn:ppp  
sub PortPeer {
    my ($fh) = @_;
    my $cli = getpeername($fh);
    my ($port, $iaddr) = unpack_sockaddr_in($cli);
    my $ip_addr = inet_ntoa($iaddr);
    return ($ip_addr.":".$port);
}

#------------------------------------------------------------------
# Now() get current time as string
# - return time + usec as string:  sssssssss.uuuuuu
sub Now() {
    my ($sec, $usec) = gettimeofday();
    my $res = sprintf("%010ld.%06ld", $sec, $usec);
    return($res);
}
