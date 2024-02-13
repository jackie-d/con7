# Con7

#### A full commands suite in Perl for your command line interface

*2024-1-13 Under development*

## Requirements

#### Install Perl

Install Perl from ActiveState or from Strawberry Perl

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

## Usage

`perl ./con7.pl <command> [args]`

### Command lists

- `go` \<shortcut_name>
- `goset` \<shortcut_name> \[shortcut_path\]
- `note`
- `zip` \<filename> 
- `unzip` \<filename>
- `crypt` \<filename>
- `decrypt` \<filename>
- `open` \<filename>
- `launch` \<program_name>
- `shutdown`
- `restart` 
- `uphistory` 
- `myhistory` 
- `myenv`
- `new`
- `web` \<URL>
- `todo` <add|list|next> \[content\]
- `disk`
- `tree`

Currently `go`, `uphistory`, `myhistory`, `myenv` commands needs to copy-paste the output to new command by the user or to run as:

*For linux*

`bash --rcfile <(perl con7.pl go c)`

*For windows*

`perl con7.pl go c | iex`