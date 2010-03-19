package _BC;
use Class::Homonymous_Union sub{eval shift}, 'branch_1', 'branch_3';

#sub found_in_A() { return('A2'); };
sub found_in_B() { return('B2'); };
sub found_in_C() { return('C2'); };

1;