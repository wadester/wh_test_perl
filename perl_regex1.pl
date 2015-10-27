#!/usr/bin/perl -w
#
# Module:   perl_regex1.pl
# Purpose:  This module demonstrates some Perl regular expressions
# Author:   Wade Hampton
# Date:     10/27/2015
# Notes:
# 1) TBD
#
use warnings;
use strict;

my $s = "This is a very\ long! stringish string with lots, lots, lots of stuff!.!*(&(";

print "perl_regex1.pl:  simple regex in Perl\n";
print "Input=" . $s . "\n";

my $s_test = "lot";
print "Does it contain ". $s_test ."?\n";

if ($s =~ /$s_test/) {
    print "YES\n";
}


print "Testing using the default variable \$_\n";
$_ = $s;
if (/$s_test/) {
    print "Also found \"$s_test\" in \$_\n";
}


$s_test = "junk";
print "Testing \"$s_test\" ";
if (/$s_test/) {
    print "Found\n";
} else {
    print "Nope, not found\n";
}

print "Testing for not matching \"$s_test\" ";
if ($s !~ /$s_test/) {
    print "Not found\n";
} else {
    print "Found\n";
}

$s_test = "^This";
print "Testing matching string at start using ^\n";
if ($s =~ /$s_test/) {
    print "Found\n";
} else {
    print "Not found\n";
}





