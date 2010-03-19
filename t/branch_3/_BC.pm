package _BC;
use Class::Homonymous_Union sub{eval shift}, 'branch_1', 'branch_2';

sub found_in_A() { return('A3'); };
sub found_in_B() { return('B3'); };
sub found_in_C() { return('C3'); };

1;