#!/usr/bin/perl -W
use strict;
use Test::Simple tests => 36;

use Class::Homonymous_Union 
	'branch_2', 'branch_3', 't/branch_2', 't/branch_3';

use lib 'branch_1', 't/branch_1';
use ABC;

ok(defined(&ABC::found_in_A), 'pkg ABC branch 1 method A (definedness)');
ok(defined(&ABC::found_in_B), 'pkg ABC branch 1 method B (definedness)');
ok(defined(&ABC::found_in_C), 'pkg ABC branch 1 method C (definedness)');
ok(defined(&ABC_TMP100::found_in_A), 'pkg ABC branch 2 method A (definedness)');
ok(defined(&ABC_TMP100::found_in_B), 'pkg ABC branch 2 method B (definedness)');
ok(defined(&ABC_TMP100::found_in_C), 'pkg ABC branch 2 method C (definedness)');
ok(!defined(&ABC_TMP101::found_in_A), 'pkg ABC branch 3 method A (definedness)');
ok(!defined(&ABC_TMP101::found_in_B), 'pkg ABC branch 3 method B (definedness)');
ok(!defined(&ABC_TMP101::found_in_C), 'pkg ABC branch 3 method C (definedness)');

my $obj1 = bless( \(my $o1 = 0), 'ABC');
ok($obj1->found_in_A eq 'A1', 'pkg ABC method resolved by branch 1');
ok($obj1->found_in_B eq 'B1', 'pkg ABC method resolved by branch 1');
ok($obj1->found_in_C eq 'C1', 'pkg ABC method resolved by branch 1');

use _BC;

ok(!defined(&_BC::found_in_A), 'pkg _BC branch 1 method A (definedness)');
ok(!defined(&_BC::found_in_B), 'pkg _BC branch 1 method B (definedness)');
ok(defined(&_BC::found_in_C), 'pkg _BC branch 1 method C (definedness)');
ok(!defined(&_BC_TMP100::found_in_A), 'pkg _BC branch 2 method A (definedness)');
ok(defined(&_BC_TMP100::found_in_B), 'pkg _BC branch 2 method B (definedness)');
ok(defined(&_BC_TMP100::found_in_C), 'pkg _BC branch 2 method C (definedness)');
ok(defined(&_BC_TMP101::found_in_A), 'pkg _BC branch 3 method A (definedness)');
ok(defined(&_BC_TMP101::found_in_B), 'pkg _BC branch 3 method B (definedness)');
ok(defined(&_BC_TMP101::found_in_C), 'pkg _BC branch 3 method C (definedness)');

my $obj2 = bless( \(my $o2 = 0), '_BC');
ok($obj2->found_in_A eq 'A3', 'pkg _BC method A resolved by branch 3');
ok($obj2->found_in_B eq 'B2', 'pkg _BC method B resolved by branch 2');
ok($obj2->found_in_C eq 'C1', 'pkg _BC method C resolved by branch 1');

use __C;

ok(!defined(&__C::found_in_A), 'pkg __C branch 1 method A (definedness)');
ok(!defined(&__C::found_in_B), 'pkg __C branch 1 method B (definedness)');
ok(!defined(&__C::found_in_C), 'pkg __C branch 1 method C (definedness)');
ok(defined(&__C_TMP100::found_in_A), 'pkg __C branch 3 method A (definedness)');
ok(defined(&__C_TMP100::found_in_B), 'pkg __C branch 3 method B (definedness)');
ok(defined(&__C_TMP100::found_in_C), 'pkg __C branch 3 method C (definedness)');
ok(!defined(&__C_TMP101::found_in_A), 'pkg __C branch - method A (definedness)');
ok(!defined(&__C_TMP101::found_in_B), 'pkg __C branch - method B (definedness)');
ok(!defined(&__C_TMP101::found_in_C), 'pkg __C branch - method C (definedness)');

my $obj3 = bless( \(my $o3 = 0), '__C');
ok($obj3->found_in_A eq 'A3', 'pkg __C method A resolved by branch 3');
# branch branch_1/__C.pm is intentially broken
ok($obj3->found_in_B eq 'B3', 'pkg __C method B resolved by branch 3');
ok($obj3->found_in_C eq 'C3', 'pkg __C method C resolved by branch 3');

exit(0);