package Synopsis;
use strict;
use Class::Homonymous_Union sub{eval shift};

sub found_in_A() { print "A pkg name: ", __PACKAGE__, "\n"; };
#sub found_in_B() { print "A pkg name: ", __PACKAGE__, "\n"; };
#sub found_in_C() { print "A pkg name: ", __PACKAGE__, "\n"; };

1;