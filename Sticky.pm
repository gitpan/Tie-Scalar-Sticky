package Tie::Scalar::Sticky;

use strict;
use base qw(Tie::Scalar);
use vars qw($VERSION);

$VERSION = '1.00';

sub TIESCALAR {
	my $class = shift;
	my $self;
	return bless \$self, $class;
}

sub STORE {
	my ($self,$val) = @_;
	$$self = $val if defined $val && $val ne '';
}

sub FETCH {
	my $self = shift;
	return $$self;
}

1;

=pod

=head1 NAME

Tie::Scalar::Sticky 
   - Block undef and empty string assignments

=head1 SYNOPSIS

   use strict;
   use Tie::Scalar::Sticky;

   tie my $sticky, 'Tie::Scalar::Sticky';

   $sticky = 42;
   $sticky = '';       # still 42
   $sticky = undef;    # still 42
   $sticky = 0;        # now it's zero

=head1 DESCRIPTION

Scalars tie'ed to this module will 'reject' any assignments
of undef or the empty string. It simply removes the need for
you to validate assignments, such as:

   $var = $val if defined $val && $val ne '';

Actually, that is the exact code used in this module. So, why
do this? Because i recently had to loop through a list where
some items were undefined and the previously defined value
should be used instead. In a nutshell:

   tie my $sticky, 'Tie::Scalar::Sticky';
   for (3,undef,2,'',1,0) {
      $sticky = $_;
      print $sticky, ' ';
   }

Should print: 3 3 2 2 1 0

=head1 AUTHOR 

Jeffrey Hayes Anderson <captvanhalen@yahoo.com>

=head1 COPYRIGHT

Copyright (c) 2003 Jeffrey Hayes Anderson.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

=cut
