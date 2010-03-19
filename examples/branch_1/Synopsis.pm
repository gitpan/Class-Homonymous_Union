package Synopsis;
use strict;
use Class::Homonymous_Union sub{eval shift}; # optional

#sub found_in_A() { print "B pkg name: ", __PACKAGE__, "\n"; };
sub found_in_B() { print "B pkg name: ", __PACKAGE__, "\n"; };
#sub found_in_C() { print "B pkg name: ", __PACKAGE__, "\n"; };

1;