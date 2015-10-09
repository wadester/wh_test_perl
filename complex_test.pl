#!/usr/bin/perl -w
#
# Module:   complex_test.pl
# Purpose:  Complex numbers and math
# Author:   Wade Hampton
# Date:     10/9/2015
# Notes:
# 1) See:
#      http://perldoc.perl.org/Math/Complex.html
#
use Math::Complex;

# create complex number using either make or cplx
$z1 = Math::Complex->make(1,2);
$z2 = cplx(3,4);

print "Z1=$z1\n";
print "Z2=$z2\n";

# create using polar notation using emake or cplxe
$z3 = Math::Complex->emake(-1,pi/3);
$z4 = cplxe(-1,pi/2);
print "Z3=$z3\n";
print "Z4=$z4\n";

# convert from polar notation to cartesian
$z5 = cplx($z3);
$z5->display_format(style => "cartesian");
print "Z5=$z5\n";

# some math on it
$r = Re($z5);
$i = Im($z5);
print "Z5=$r + $i*j\n";

$c = cos($z5);
$z5->display_format('format' => '%.6f');
printf "cos(%s)=%f + %f*j\n", "$z5", Re($c), Im($c);






