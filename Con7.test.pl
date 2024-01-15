use Test::Most tests => 2;
use Test::MockModule;
use Test::Output;

use FindBin qw( $RealBin ); 
use lib $RealBin;

require 'Con7.pm';

# Test Go

do {
    my $mock = Test::MockModule->new("Con7");
    $mock->redefine("getPathFromName", sub {
        return '';
    });
    
    stdout_is( sub { Con7::go(); } , "cd \n", 'Correctly returns "go" command' );

    $mock->redefine("getPathFromName", sub {
        $mock->original("getPathFromName");
    });
};

# Test Go Set

do {
    my $NAME_VALUE = 'NAME';
    my $WHERE_VALUE = '/TMP';

    my $mock = Test::MockModule->new("Con7");

    my $name;
    my $where;
    $mock->redefine("setPathForName", sub {
        $name = shift;
        $where = shift;
    });

    $ARGV[1] = $NAME_VALUE;
    $ARGV[2] = $WHERE_VALUE;
    my $avoidOutpunt = stdout_from( sub{ Con7->goset(); } );

    is $name, $NAME_VALUE, 'Go Set name read correctly';
    is $where, $WHERE_VALUE, 'Go Set path read correctly';
};