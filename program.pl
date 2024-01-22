
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
    case 'new' { Con7->newConsole(); }
    case 'web' { Con7->openWebPage(); }
    case 'todo' { Con7->todo(); }
    else { tryLaunch(); }
}

sub tryLaunch {
    $isLaunchDone = Con7::launchProgram(@ARGV[0]);
    if ( $isLaunchDone ) {
        exit;
    }
    if ( rindex($ARGV[0], "http://", 0) == 0 || rindex($ARGV[0], "https://", 0) == 0  ) {
        Con7::openWebPage(@ARGV[0]);
        exit;
    }
    print "Command not found\n";
}

#note
# for commands to be injected in current console the script have to be executed as i.e.
# bash --rcfile <(/usr/bin/perl program.pl go c)