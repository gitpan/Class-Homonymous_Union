#!/usr/bin/perl -W
use strict;

use Class::Homonymous_Union;
Class::Homonymous_Union::transport(sub{eval shift}, \'0/0');
exit(0);