package Tie::Scalar::Sticky;

use strict;
use vars qw($VERSION);

use Symbol;
use Tie::Scalar;
use base 'Tie::StdScalar';

$VERSION = '1.02';

sub TIESCALAR {
	my $class = shift;
	my $self = *{gensym()};
	@$self = @_;
	return bless \$self, $class;
}

sub STORE {
	my($self,$val) = @_;
	$$$self = $val
	if defined $val and $val ne '' and 0 == grep { $val eq $_ } @$$self;
}

sub FETCH {
	my $self = shift;
	return $$$self;
}

1;

=pod

=head1 NAME

Tie::Scalar::Sticky - Block assignments to scalars

=head1 SYNOPSIS

   use strict;
   use Tie::Scalar::Sticky;

   tie my $sticky, 'Tie::Scalar::Sticky';

   $sticky = 42;
   $sticky = '';       # still 42
   $sticky = undef;    # still 42
   $sticky = 0;        # now it's zero

   tie my $sticky, 'Tie::Scalar::Sticky' => qw/ foo bar /;

   $sticky = 42;
   $sticky = 'foo';    # still 42
   $sticky = 'bar';    # still 42
   $sticky = 0;        # now it's zero

=head1 DESCRIPTION

Scalars tie'ed to this module will 'reject' any assignments
of undef or the empty string or any of the extra arugments
provided to C<tie()>. It simply removes the need for
you to validate assignments, such as:

   $var = $val if defined $val && $val ne '';

Actually, that is the exact code used in this module. So, why
do this? Because i recently had to loop through a list where
some items were undefined and the previously defined value
should be used instead. In a nutshell:

   tie my $sticky, 'Tie::Scalar::Sticky' => 9, 'string';
   for (3,undef,'string',2,'',1,9,0) {
      $sticky = $_;
      print $sticky, ' ';
   }

Should print: 3 3 2 2 1 0

=head1 AUTHOR 

Jeffrey Hayes Anderson C<E<lt>captvanhalen@yahoo.comE<gt>>

=head1 CREDITS 

Dan [broquaint] Brook for allowing T::S::S to ignore more
than undef and the empty string. (Half of this code has
been provided by him. ;))

Perl Monks for the education.

Jeffrey Hayes Anderson C<E<lt>captvanhalen@yahoo.comE<gt>>

=head1 COPYRIGHT

Copyright (c) 2003 Jeffrey Hayes Anderson.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

=cut
