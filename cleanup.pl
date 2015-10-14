#!/usr/bin/perl -w
#
# Module:   cleanup.pl
# Purpose:  This module cleans up test files
# Author:   Wade Hampton
# Date:     10/9/2015
# Notes:
# 1) Add files to be cleaned up here....
#
use warnings;

my @clean_files = qw(testfile.txt);
# push @clean_files, 'newfile';

print "cleanup.pl:  remove a set of files\n";
print "  Could unlink all with one cmd and get count:\n";
print "    my \$u_count = unlink \@clean_files;\n";
foreach my $cf (@clean_files) {
    unlink $cf or warn "Could not unlink $cf: $!";
}
