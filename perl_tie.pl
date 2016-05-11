#!/usr/bin/perl -w
#
# Module:   perl_tie.pl
# Purpose:  This module ties a file and reads data from it.
# Author:   Wade Hampton
# Date:     5/11/2016
# Notes:
# 1) http://stackoverflow.com/questions/8963400/the-correct-way-to-read-a-data-file-into-an-array
#
use warnings;
use Tie::File;

my $ifile = "README.md";

# open the file into an array and chomp each line:
open IFILE, '<', $ifile or die "could not open $ifile\n";
chomp(my @lines = <IFILE>);
close IFILE;
$n_recs = @lines;
print "Lines=$n_recs\n";


# use tie to access the file
tie @array, 'Tie::File', $ifile or die "could not open $ifile\n";

# $array[13] = 'blah';     # line 13 of the file is now 'blah'
print $array[2]."\n";      # display line 2 of the file

$n_recs = @array;          # how many records are in the file?
print "Lines=$n_recs\n";
# $#array -= 2;            # chop two records off the end

