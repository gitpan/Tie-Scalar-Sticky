use Test::More qw(no_plan);

require_ok('Sticky');

tie my $sticky, 'Tie::Scalar::Sticky';

$sticky = 5;
is($sticky,5,'assigned digit');

$sticky = undef;
is($sticky,5,'rejected undef');

$sticky = 0;
is($sticky,0,'assigned zero as digit');

$sticky = undef;
is($sticky,0,'rejected undef');

$sticky = 'a';
is($sticky,'a','assigned alpha');

$sticky = '';
is($sticky,'a','rejected empty string');

$sticky = '0';
is($sticky,0,'assigned zero as char');
