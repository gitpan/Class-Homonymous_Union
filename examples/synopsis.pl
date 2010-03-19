#!/usr/bin/perl -W
use strict;

BEGIN { $Class::Homonymous_Union::DEBUG = 1; }
use Class::Homonymous_Union 'branch_1', 'branch_2';

# ... while the following could be in another package
use Synopsis;

my $obj = bless( \(my $o = 0), 'Synopsis');
$obj->found_in_A;
$obj->found_in_B;
$obj->found_in_C;

exit(0);