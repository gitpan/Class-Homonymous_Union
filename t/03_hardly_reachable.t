#!/usr/bin/perl -W
use strict;
use Test::Simple tests => 4;

use Class::Homonymous_Union ':void';
my $buffer;

exit(1) if (-f '/asdf.txt');
eval q{ Class::Homonymous_Union::read_file_contents('/asdf.txt', $buffer); };
ok($@ =~ m/asdf.txt/, 'Reading from non-existent file /asdf.txt.');

eval q{ Class::Homonymous_Union::read_file_contents('/dev/null', $buffer); };
ok($@ =~ m/null: read:/, "Can't read from /dev/null.");

eval q{ Class::Homonymous_Union::transport(sub{eval shift}, \'0/0'); };
ok($@ =~ m/Illegal division by zero/, 'Run-time error in transport (illegal division by zero)');

my $name = $0;
$name =~ s,\.t$,.pl,sg;
my $output = qx{$name 2>&1};
ok($output =~ m/Offending Code/, 'Shows code in non-eval context');

#Class::Homonymous_Union::transport(sub{eval shift}, \'0/0');

exit(0);
