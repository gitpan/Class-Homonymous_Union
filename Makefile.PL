use ExtUtils::MakeMaker;

WriteMakefile(
	'NAME'		=> 'Class::Homonymous_Union',
	'VERSION_FROM'	=> 'lib/Class/Homonymous_Union.pm',
	'AUTHOR'	=> 'Winfried Trumper <pub+perl@wt.tuxomania.net>',
	'LICENSE'	=> 'perl',
	'PREREQ_PM'	  => { 
		'Test::Simple' => 0.01,
	},
);