package Con7;

use Cwd;
use JSON::XS qw(encode_json decode_json);
use File::Slurp qw(read_file write_file);
use IO::Compress::Zip ();
use IO::Uncompress::Unzip ();
use Filter::Crypto::CryptFile qw(:DEFAULT $ErrStr);

my $LINKS = './storagefile-links';
my $NOTE = './storagefile-note';

##

sub go {
    my $where = $ARGV[1];
    my $path = getPathFromName($where);
    print("cd $path");
    print "\n";
}

sub goset {
    my $name = $ARGV[1];
    my $where = $ARGV[2] // getcwd;
    setPathForName($name, $where);
    print "New path link saved.\n";
}

####

sub note {
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

sub zip {
    my $what = $ARGV[1];
    if ( ! -e $what ) {
        print "Can't compress: file not found\n";
        exit;
    }
    IO::Compress::Zip::zip $what => "$what.zip" or die "Zip failed: $ZipError\n";
}

sub unzip {
    my $what = $ARGV[1];
    if ( ! -e $what ) {
        print "Can't decompress: file not found\n";
        exit;
    }
    IO::Uncompress::Unzip::unzip $what => substr($what, 0, -4) or die "Unzip failed: $ZipError\n";
}

sub cryptFile {
    my $what = $ARGV[1];
    if ( ! -e $what ) {
        print "Can't encrypt: file not found\n";
        exit;
    }
    crypt_file($what, "$what.crypt") or die "Crypting file failed: $ErrStr\n";
}

sub decrypt {
    my $what = $ARGV[1];
    if ( ! -e $what ) {
        print "Can't encrypt: file not found\n";
        exit;
    }
    $newName = '';
    if ( $what =~ /\.crypt\z/ ) {
        $newName = substr($what, 0, -6);
    } else {
        $newName = 'output_' . $what;
    }
    crypt_file($what, $newName, CRYPT_MODE_DECRYPT) or die "Derypting file failed: $ErrStr\n";
}

####

sub getPathFromName {
    my $name = shift;
    if ( ! -e $LINKS ) {
        return;
    }
    my $json = read_file($LINKS, { binmode => ':raw' });
    my %hash = %{ decode_json($json) };
    return $hash{$name};
}

sub setPathForName {
    my $name = shift;
    my $where = shift;

    my %hash;
    if ( -e $LINKS ) {
        my $json = read_file($LINKS, { binmode => ':raw' });
        %hash = %{ decode_json($json) };
    }

    $hash{$name} = $where;
    
    my $json = encode_json \%hash;
    write_file($LINKS, { binmode => ':raw' }, $json);
}

1;