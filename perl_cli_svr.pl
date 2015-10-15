#!/usr/bin/perl -w
#
# Module:   perl_cli_svr.pl
# Purpose:  This is a Perl socket client and server w/ fork
# Author:   XMODULO, mods by Wade Hampton
# Date:     10/15/2015
# Notes:
# 1) Ref:
#      http://xmodulo.com/how-to-write-simple-tcp-server-and-client-in-perl.html

use warnings;
use IO::Socket::INET;
use Time::localtime;
use Time::HiRes qw( usleep ualarm gettimeofday tv_interval );

# prototype
sub Now();

# define the server info
our $port = 9876; # port to listen on
our $lcnt = 5;    # listen count
our %clients;     # hash of client FH data, key is file number

print Now().":  perl_cli_svr.pl:  client/server test from example\n";
print "                    listening on port $port\n";
 
# auto-flush on socket
$| = 1;


# fork a dummy telnet to get the data from the socket
defined (my $pid = fork) or die "can't fork:  $!";

# if this is the child, make this the server
if ($pid == 0) {

    print Now().":  server starting\n";

    # creating a listening socket
    my $socket = new IO::Socket::INET (
	LocalHost => '0.0.0.0',
	LocalPort => $port,
	Proto => 'tcp',
	Listen => $lcnt,
	Reuse => 1
	);
    die "ERROR cannot create socket $!\n" unless $socket;
    print Now().":  server waiting for client connection on port $port\n";
    
    while(1)
    {
	# waiting for a new client connection
	my $client_socket = $socket->accept();
	
	# get information about a newly connected client
	my $client_address = $client_socket->peerhost();
	my $client_port = $client_socket->peerport();
	print Now().":  connection from $client_address:$client_port\n";
	
	# read up to 1024 characters from the connected client
	my $data = "";
	$client_socket->recv($data, 1024);
	print Now().":  received data: $data\n";
	
	# write response data to the connected client
	$data = "ok";
	$client_socket->send($data);
	
	# notify client that response has been sent
	shutdown($client_socket, 1);
	
	# -- hack to only run one client!
	last;
	
    }
    
    $socket->close();
} 
# else this is the parent, run the client
else {

    # give child time to create the socket
    usleep(1000);
    print Now().":  client starting\n";

    # create a connecting socket
    my $socket = new IO::Socket::INET (
	PeerHost => 'localhost',
	PeerPort => $port,
	Proto => 'tcp',
	);
    die "cannot connect to the server $!\n" unless $socket;
    print Now().":  connected to the server\n";
    
    # data to send to a server
    my $req = 'hello world';
    my $size = $socket->send($req);
    print Now().":  sent data of length $size\n";
    
    # notify server that request has been sent
    shutdown($socket, 1);
    
    # receive a response of up to 1024 characters from server
    my $response = "";
    $socket->recv($response, 1024);
    print Now().":  received response: $response\n";
    
    $socket->close();
}

#------------------------------------------------------------------
# Now() get current time as string
# - return time + usec as string:  sssssssss.uuuuuu
sub Now() {
    my ($sec, $usec) = gettimeofday();
    my $res = sprintf("%010ld.%06ld", $sec, $usec);
    return($res);
}
