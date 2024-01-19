
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
    case 'launch' { Con7->openProgram(); }
    case 'shutdown' { Con7->shutdown(); }
    case 'restart' { Con7->restart(); }
    case 'uphistory' { Con7->saveHistory(); }
    case 'myhistory' { Con7->reloadHistory(); }
    case 'myenv' { Con7->reloadEnv(); }
    else { tryLaunch(); }
}

sub tryLaunch {
    $isLaunchDone = Con7::launchProgram(@ARGV[0]);
    if ( ! $isLaunchDone ) {
        print "Command not found\n";
    }
}