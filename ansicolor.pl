#!/usr/bin/perl -w
#
# Module:   ansicolor.pl
# Purpose:  Print in color on std term
# Author:   Wade Hampton
# Date:     10/9/2015
# Notes:
# 1) Based on perl cookbook
#
# includes
use Term::ANSIColor;

print color("red"), "This should be red\n";
print color("blue"), "This should blue and ";
print color("green"), "green\n";
print color("reset"), "Now normal....\n";

