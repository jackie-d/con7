requires 'Switch';
requires 'Cwd';
requires 'JSON::XS';
requires 'File::Slurp';
requires 'Filter::Crypto::CryptFile';

on 'test' => sub {
    requires 'Test::Most';
    requires 'Test::Output';
    requires 'Test::MockModule';
    requires 'Test::MockObject';
};