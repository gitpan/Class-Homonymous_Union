#!/usr/bin/perl -W
use strict;
use Test::Simple tests => 3;

BEGIN { $Class::Homonymous_Union::DEBUG = 1; }
use Class::Homonymous_Union 
	'branch_4', 'branch_4', 't/branch_2', 't/branch_3';

use lib 'branch_1', 't/branch_1';
use ABC;

my $obj1 = bless( \(my $o1 = 0), 'ABC');
ok($obj1->found_in_A eq 'A1', 'pkg ABC method A resolved by branch 1');
ok($obj1->found_in_B eq 'B1', 'pkg ABC method B resolved by branch 1');
ok($obj1->found_in_C eq 'C1', 'pkg ABC method C resolved by branch 1');

exit(0);