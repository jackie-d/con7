# Con7

#### A full commands suite in Perl for your command line interface

*2024-1-13 Under development*

## Requirements

#### Modules

It's needed to install the following modules before running the script:

- Switch
- Cwd
- JSON::XS
- File::Slurp
- Filter::Crypto::CryptFile

You can install it by this:

`cpan Switch, Cwd, Json::XS, File::Slurp, Filter::Crypto::CryptFile`

or by ActiveState

```
state install Switch
state install Cwd
state install Json-XS
state install File-Slurp
...
```

or by cpanfile

`cpanm --installdeps .`


## Testing

If you would like to improve this tool and write more tests you have to also install these modules: 

`Test::Most` 
`Test::Output` 
`Test::MockModule`
`Test::MockObject`
`Test::Mock::Cmd`