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

print "perl_data1.pl:  iteration over lists and misc functions\n";

# Create a list by using ` ` to run a command and consume output
my @l0 = `ls -1 *.pl`;
my $l0_cnt = @l0;

# create slice of first 4 elements, first is 0
# - note end of list is 3 so this is for elements [0] to [3]
my @l1 = @l0[0..3];

# list in scalar context returns size
my $l1_cnt = @l1;    

print "Original list size=$l0_cnt, after slice=$l1_cnt\n";

# iterate over all files in the list using for
my $ii=1;
print "Iterating on list using for my \$var (\@var1)\n";
for my $pl_file (@l1) {
    # use chomp() to remove trailing whitespace and \n
    # similar to rstrip() in Python
    chomp($pl_file);
    printf "File %04d is %s\n", $ii++,  $pl_file;
}

print "Poping entry and pushing new entry\n";
my $junk = 0;
pop @l1, $junk;
push @l1, "junk.pl";

# iterate over all files in the list using foreach -- same as before
$ii=1;
print "Iterating using foreach my \$var (\@var1)\n";
foreach my $pl_file (@l1) {
    chomp($pl_file);
    printf "File %04d is %s\n", $ii++,  $pl_file;
}

$ii=1;
print "Iterating using shift\n";
my @l2 = @l1;
for(;;) {
  my $item = shift @l2;
  if (! defined $item) {
	last;
  }
  printf "File %04d is %s\n", $ii++,  $item;
}

print "Using unshift to add at first of the list\n";
unshift (@l1, "new.pl");

$ii=1;
foreach my $pl_file (@l1) {
    chomp($pl_file);
    printf "File %04d is %s\n", $ii++,  $pl_file;
}

print "Using shift to remove first element from the list\n";
shift @l1;
$ii=1;
foreach my $pl_file (@l1) {
    chomp($pl_file);
    printf "File %04d is %s\n", $ii++,  $pl_file;
}

# to sort:  @l1 = sort @l1;

# define some hashes which start with %
my %h1 = (
    "k1",  "val1",
    "k2",  "val22",
    "k3",  "val333"
    );

print "H1 is:\n";
for (keys %h1) {
    print "key $_, val $h1{$_}\n";
}

# add new entry to H1
$h1{k4} = "val4444";

# delete key 1
delete $h1{k1};

print "H1 is:\n";
for (keys %h1) {
    print "key $_, val $h1{$_}\n";
}

print "Sorting the keys\n";
my @h1keys = keys %h1;
@h1keys = sort @h1keys;
for my $mykey (@h1keys) {
    print "key $mykey, val $h1{$mykey}\n";
}

