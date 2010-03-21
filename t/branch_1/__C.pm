package __C;
use Class::Homonymous_Union sub{eval shift},
	'branch_2', 'branch_3', 't/branch_2', 't/branch_3',
	'branch_1', 't/branch_1';

#sub found_in_A() { return('A1'); };
#sub found_in_B() { return('B1'); };
#sub found_in_C() { return('C1'); };

1;
