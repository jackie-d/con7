
use Switch;

use FindBin qw( $RealBin ); 
use lib $RealBin;

require 'Con7.pm';

my $firstArgument = $ARGV[0];

if (-e $firstArgument) {
    Con7::openWithDefaultApp($firstArgument);
    exit; 
}

my $command = $firstArgument;

switch( $command ) {
    case 'go' { Con7->go(); }
    case 'goset' { Con7->goset(); }
    case 'note' { Con7->note(); }
    case 'zip' { Con7->zip(); }
    case 'unzip' { Con7->unzip(); }
    case 'crypt' { Con7->cryptFile(); }
    case 'decrypt' { Con7->decrypt(); }
    case 'open' { Con7->openWithDefaultApp(); }
    else { print "Command not found\n"; }
}