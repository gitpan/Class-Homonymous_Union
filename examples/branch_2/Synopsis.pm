package Synopsis;
use strict;
use Class::Homonymous_Union sub{eval shift}; # not required

#sub found_in_A() { print "C pkg name: ", __PACKAGE__, "\n"; };
#sub found_in_B() { print "C pkg name: ", __PACKAGE__, "\n"; };
sub found_in_C() { print "C pkg name: ", __PACKAGE__, "\n"; };

1;