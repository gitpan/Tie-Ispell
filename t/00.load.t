# -*- cperl -*-
use Test::More tests => 4;

BEGIN {
  use_ok( 'Tie::Ispell' );
}

#diag( "Testing Tie::Ispell $Tie::Ispell::VERSION" );

tie %dic, 'Tie::Ispell', "english";

is( $dic{dog}, "dog");

is( $dic{dogs}, "dog");

is( $dic{zbr}, undef);
