# Easy alias jump for console

use Switch;
use Cwd;
#use warnings;

use JSON::XS qw(encode_json decode_json);
use File::Slurp qw(read_file write_file);

my $STORAGE = './storage';

my $firstArgument = $ARGV[0];

if (-e $firstArgument) {
    #handleFile($firstArgument);
    return; 
}

my $command = $firstArgument;

switch( $command ) {
    case 'go' { go(); }
    case 'goset' { goset(); }
    else {}
}

sub go() {
    my $where = $ARGV[1];
    my $path = getPathFromName($where);
    print("cd $path");
    print "\n";
}

sub goset() {
    my $name = $ARGV[1];
    my $where = $ARGV[2] // getcwd;
    my $path = setPathForName($name, $where);
    print "New path link saved.\n";
}

sub getPathFromName() {
    my $name = shift;
    my $json = read_file($STORAGE, { binmode => ':raw' });
    my %hash = %{ decode_json($json) };
    return $hash{$name};
}

sub setPathForName() {
    my $name = shift;
    my $where = shift;

    my $json = read_file($STORAGE, { binmode => ':raw' });
    my %hash = %{ decode_json($json) };

    $hash{$name} = $where;
    
    my $json = encode_json \%hash;
    write_file($STORAGE, { binmode => ':raw' }, $json);
}