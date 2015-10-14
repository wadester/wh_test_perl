#!/usr/bin/perl -w
#
# Module:   perl_data.pl
# Purpose:  Perl's data types
# Author:   Wade Hampton
# Date:     10/14/2015
# Notes:
# 1) Simple data types in Perl
#    ref:  http://learn.perl.org/books/beginning-perl/
#
use warnings;
use strict;

# define some scalars -- these use $
my $s1 = 5;
my $s2 = 3.14;
my $s3 = "hello";
# quoted string, can use qq<...> or # or ...
my $s4 = qq('"Hello, this is'nt a test!");
print "Values = $s1, $s2, $s3, $s4\n";

# use here documents
print<<EOF;

This is a string.
This is another string!

EOF

# define some lists (arrays) which start with @
my @l1 = ();  # null list
my @l2 = (1, 2, 3, 4);
my @l3 = (1, "asdf", 2, "jkl;");
# use the qw(...) for lists of words and whitespace
my @l4 = qw(This is a test);
print "Lists:  @l1, @l2, @l3\n";
print "l4: @l4\n";

# define some hashes which start with %




