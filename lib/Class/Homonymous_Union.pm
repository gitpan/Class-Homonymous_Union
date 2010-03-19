package Class::Homonymous_Union;
use strict;
use warnings;
use Carp qw();

our $VERSION = '0.01';

our $DEBUG //= 0;
Internals::SvREADONLY($DEBUG, 1);
sub DEBUG() { $DEBUG };

# for the temporary package name
my $POSTFIX = 'TMP';

# where to search
my @BRANCHES = ();

# takes the package name AB::CD and returns the package file name AB/CD.pm
sub pkg_file_by_name($) {
	my $pkg_file = $_[0];
	$pkg_file =~ s,::,/,sg;
	$pkg_file .= '.pm';

	return($pkg_file);
}

# takes code and the visit point and performs the execution
sub transport($$;@) {
	my ($visit_point, $code_ref) = (shift, shift);

	my $sa = $@;
	$visit_point->($$code_ref, @_);
	if ($@) {
		my $msg = '';
		# only add the hint if not running in an eval context
		$msg .= "Offending Code:\n$$code_ref\n" unless ($^S);
		$msg .= $@;
		Carp::confess($msg);
	}
	# restore original value of $@ (good practice?)
	$@ = $sa;
	return;
}

# reads file contents into a buffer
sub read_file_contents($$) {
        open(F, '<', $_[0]) || die("$_[0]: open/r: $!\n");
        read(F, $_[1], (stat(F))[7]) || die("$_[0]: read: $!\n");
        close(F);
        return;
}

# implicitly called when using the module
# takes a visit point or a list of directories to search
sub import($$;@) {
	my $class = shift;

	print STDERR "#--- Starting debugging.\n" if (DEBUG);

	if (ref($_[0]) ne 'CODE') {
		@BRANCHES = @_;
		print STDERR "| \@BRANCHES set to ", 
			join(', ', @BRANCHES), "\n" if (DEBUG);
		print STDERR "#--- Ending debugging.\n" if (DEBUG);
		return;
	}
	my $visit_point = shift;

	my $pkg_name = (caller)[0];
	print STDERR "| Package name '$pkg_name'.\n" if (DEBUG);

	my $pkg_file = pkg_file_by_name($pkg_name);
	print STDERR "| Package file '$pkg_file'.\n" if (DEBUG);

	my @inc = scalar(@_) ? @_ : @BRANCHES;

	my $counter = 100;
	my @HOMONYMOUS = ();
	foreach my $directory (@inc) {
		print STDERR "| Trying directory '$directory'.\n" if (DEBUG);
		next unless (-d $directory);

		my $candidate = "$directory/$pkg_file";
		next unless (-f $candidate);
		print STDERR "| Using file '$candidate'.\n" if (DEBUG);

		my $new_name = "$pkg_name\_$POSTFIX$counter";
		read_file_contents($candidate, my $buffer);
		next unless ($buffer =~ s/(^|\n)([\s\t]*package[\s\t]+)$pkg_name([\s\t]*;[\s\t]*\n)/$1$2$new_name$3/s);
		$buffer =~ s/(^|\n)[\s\t]*use[\s\t]+Class::Homonymous_Union[\s\t]+[^;]+;//sg;

		print STDERR "| Loading as package '$new_name'.\n" if (DEBUG);
		$counter += 1;
		push(@HOMONYMOUS, $new_name);
		transport($visit_point, \$buffer);
	}

	my $code = sprintf('@%s::ISA = (@%s::ISA, @_);', $pkg_name, $pkg_name);
	transport($visit_point, \$code, @HOMONYMOUS);

	if (DEBUG) {
		print STDERR "| Resulting ISA: ", join(', ', @HOMONYMOUS), "\n";
		print STDERR "#--- Ending debugging.\n";
	}
	return;
}

1;