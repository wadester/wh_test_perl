#!/usr/bin/perl -w
#
# Module:   md5.pl
# Purpose:  compute the MD5 of some data
# Author:   Wade Hampton
# Date:     10/9/2015
# Notes:
# 1) Uses Digest::MD5
#
# defaults
$tfile="testfile.txt";

# includes
use Digest::MD5;


print "md5.pl:  test of creating a digest\n";

print "Creating test file $tfile\n";
# open modes:  +< - r/w updates, +> - r/w clobber first
open TF, "+>$tfile",       or die "can't open $tfile: $!";
for (my $ii=0; $ii<10; $ii++) {
    print TF "This is a test line for %ii";
}

print "Creating digest via program and via md5sum pgm\n";

# must seek to start of file to get all of it
# http://perldoc.perl.org/functions/seek.html
seek TF,0,0;

# create digest object and add file to it
my $ctx = Digest::MD5->new;
$ctx->addfile(TF);
my $digest=$ctx->hexdigest;

print "Digest=$digest\n";
close(TF);

my $res = `md5sum $tfile`;
print "md5sum=$res\n";



