#!/usr/bin/perl -w
#
# Module:   perl_data1.pl
# Purpose:  Perl's data types with additional operations
# Author:   Wade Hampton
# Date:     10/15/2015
# Notes:
# 1) Simple data types in Perl with operations
#
use warnings;
use strict;

# Create a list by using ` ` to run a command and consume output
my @l1 = `ls -1 *.pl`;
my $ii=1;

# iterate over all files in the list
foreach my $pl_file (@l1) {
    # use chomp() to remove trailing whitespace and \n
    # similar to rstrip() in Python
    chomp($pl_file);
    printf "File %04d is %s\n", $ii++,  $pl_file;
}







