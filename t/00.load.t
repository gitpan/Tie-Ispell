# -*- cperl -*-
use Test::More tests => 12;

BEGIN {
  use_ok( 'Tie::Ispell' );
}

#diag( "Testing Tie::Ispell $Tie::Ispell::VERSION" );

tie %dic, 'Tie::Ispell', "english";

is(  $dic{dog}, "dog");
like( $dic{dogs}, qr/^dogs?$/);
is(  $dic{dfsjfhsjd}, undef);

my $nearmisses = $dic{doj};

ok(grep { $_ eq "dog" } @$nearmisses );
ok(grep { $_ eq "dot" } @$nearmisses );

ok(  exists($dic{dog}));
ok( exists($dic{dogs}));
ok(!exists($dic{dok}));
ok(! exists($dic{dfsjfhsjd}));

$dic{dfsjfhsjd} = 1;
is(  $dic{dfsjfhsjd}, "dfsjfhsjd");
ok( exists($dic{dfsjfhsjd}));
