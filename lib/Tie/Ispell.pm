package Tie::Ispell;

use warnings;
use strict;

use locale;
use IPC::Open2;

=head1 NAME

Tie::Ispell - Ties an hash with an ispell dictionary

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS


    use Tie::Ispell;

    tie %dict, 'Tie::Ispell', "english";

    if ($dict{dog}) {
      print "dog is a word"
    }

=head1 FUNCTIONS

=head2 TIEHASH

Used for the tie method. Use tie as:

  tie %dic, 'Tie::Ispell', 'dictionaryname';

=cut

sub TIEHASH {
  my $class = shift;
  my $dict  = shift;
  my $self  = { dict => $dict };

  open2($self->{read}, $self->{write}, "ispell -d $dict -a");

  my $x = $self->{read};
  <$x>;

  return bless $self, $class #amen
}


=head2 FETCH

Fetches a word from the ispell dictionary

  $dic{dogs} # returns dog
  $dic{dog}  # returns dog

=cut

sub FETCH {
  my $self = shift;
  my $word = shift;

  return undef unless $word =~ m!\w!;

  print {$self->{write}} "$word\n";
  my $x = $self->{read};
  my $ans = <$x>;

  <$x>;

  if ($ans =~ m!^\*!) {
    return $word
  } elsif ($ans =~ m!^\+\s(\w+)!) {
    return lc($1)
  } else {
    return undef;
  }

}

=head1 AUTHOR

Alberto Simoes, C<< <ambs@cpan.org> >>

Jose Joao Almeida, C<< <jj@di.uminho.pt> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-tie-ispell@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org>.  I will be notified, and then you'll automatically
be notified of progress on your bug as I make changes.

=head1 COPYRIGHT & LICENSE

Copyright 2004 Natura Project, All Rights Reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1; # End of Tie::Ispell
