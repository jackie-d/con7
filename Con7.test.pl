use Test::Most tests => 6;
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

    $mock->redefine("setPathForName", sub {
        $mock->original("setPathForName");
    });
};

## ..

## Test File and Directory Open

do {
    my $FILENAME = 'FILENAME';

    # windows
    my $mock = Test::MockModule->new("Con7");
    $mock->redefine("getCurrentOS", sub {
        return 'Win32';
    });

    # file
    $mock->redefine("isDirectory", sub {
        return 0;
    });
    my $result = Con7::getCommandToOpenFile($FILENAME);
    is $result, "start $FILENAME", 'Command to open file on windows is correct';

    # directory
    $mock->redefine("isDirectory", sub {
        return 1;
    });
    $result = Con7::getCommandToOpenFile($FILENAME);
    is $result, "explorer $FILENAME", 'Command to open directory on windows is correct';

    # linux
    $mock->redefine("getCurrentOS", sub {
        return 'Linux';
    });
    $result = Con7::getCommandToOpenFile($FILENAME);
    is $result, "xdg-open $FILENAME", 'Command to open any file on Unix is correct';

    # teardown
    $mock->redefine("getCurrentOS", sub {
        $mock->original("getCurrentOS");
    });
    $mock->redefine("getCurrentOS", sub {
        $mock->original("getCurrentOS");
    });

    1;
};