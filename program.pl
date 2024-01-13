# Easy alias jump for console

use Switch;
use Cwd;

#use warnings;

use JSON::XS qw(encode_json decode_json);
use File::Slurp qw(read_file write_file);
use IO::Compress::Zip ();
use IO::Uncompress::Unzip ();

my $LINKS = './storagefile-links';
my $NOTE = './storagefile-note';

my $firstArgument = $ARGV[0];

if (-e $firstArgument) {
    #handleFile($firstArgument);
    exit; 
}

my $command = $firstArgument;

switch( $command ) {
    case 'go' { go(); }
    case 'goset' { goset(); }
    case 'note' { note(); }
    case 'zip' { zip(); }
    case 'unzip' { unzip(); }
    else { print "Command not found\n"; }
}

####

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

####

sub note() {
    print "\033[2J";    # clear the screen
    print "\033[0;0H";  # jump to 0,0

    if ( -e $NOTE ) {
        my $text = read_file($NOTE, { binmode => ':raw' });
        print $text;
    }

    my @a;
    $a[0] = $text;
    while (<STDIN>) {
        /\S/ or last; # last line if empty
        push @a, $_;
    }

    write_file($NOTE, { binmode => ':raw' }, join('', @a) );
}

sub zip() {
    my $what = $ARGV[1];
    if ( ! -e $what ) {
        print "Can't compress: file not found\n";
        exit;
    }
    IO::Compress::Zip::zip $what => "$what.zip" or die "zip failed: $ZipError\n";
}

sub unzip() {
    my $what = $ARGV[1];
    if ( ! -e $what ) {
        print "Can't decompress: file not found\n";
        exit;
    }
    IO::Uncompress::Unzip::unzip $what => substr($what, 0, -4) or die "unzip failed: $ZipError\n";
}

####

sub getPathFromName() {
    my $name = shift;
    my $json = read_file($LINKS, { binmode => ':raw' });
    my %hash = %{ decode_json($json) };
    return $hash{$name};
}

sub setPathForName() {
    my $name = shift;
    my $where = shift;

    my $json = read_file($LINKS, { binmode => ':raw' });
    my %hash = %{ decode_json($json) };

    $hash{$name} = $where;
    
    my $json = encode_json \%hash;
    write_file($LINKS, { binmode => ':raw' }, $json);
}