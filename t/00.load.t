# -*- cperl -*-
use Test::More tests => 9;

BEGIN {
  use_ok( 'Tie::Ispell' );
}

#diag( "Testing Tie::Ispell $Tie::Ispell::VERSION" );

tie %dic, 'Tie::Ispell', "english";

is(  $dic{dog}, "dog");
is( $dic{dogs}, "dog");
is(  $dic{zbr}, undef);

ok(  exists($dic{dog}));
ok( exists($dic{dogs}));
ok(! exists($dic{zbr}));

$dic{zbr} = 1;
is(  $dic{zbr}, "zbr");
ok( exists($dic{zbr}));
