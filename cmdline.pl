#!/usr/bin/perl 
#
# Module:   cmdline.pl
# Purpose:  This module demonstrates getopt in Perl
# Author:   Wade Hampton
# Date:     10/7/2015
# Notes:
# 1) simple getopt command line processing
#
# define defaults

my $verbose = 0;
my $ifile   = "no_ifile.txt";
my $ofile   = "no_ofile.txt";

# include the getopt module
use Getopt::Std;


# print all options 
sub PrintOptions($$$) {
    my ($v, $if, $of) = @_;
    printf "Verbose=%d\n", $v;
    printf "Ifile=%s\n", $if;
    printf "Ofile=%s\n", $of;
}


print "cmdline.pl:  test of command line\n";

# this is better than using ARGV
print "Use of @ARGV input array, very-basic input processing\n";
my $cnt = @ARGV;
if ($cnt == 0) {
    print "no args\n";
} else {
    for (my $ii=0; $ii<$cnt; $ii++) {
        printf "  %04d %s\n", $ii, $ARGV[$ii];
    }
}


# parse using getopts
print "Use of getopts(), like C getopt()\n";
getopts("v:i:o:h");

# define a function for each option you wish to get
if ($opt_h) {
    print "Options:\n";
    print "  -v n    : enable verbose level n\n";
    print "  -i if   : input file if\n";
    print "  -o of   : output file of\n";
    print "  -h      : print this help\n";
    exit(0);
}

if ($opt_v) {
    $verbose = $opt_v;
}
if ($opt_i) {
    $ifile   = $opt_i;
}
if ($opt_o) {
    $ofile   = $opt_o;
}

PrintOptions($verbose, $ifile, $ofile);

exit(0);
