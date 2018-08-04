use v6.c;
use Test;
use P5readlink;

plan 8;

ok defined(::('&readlink')),            'is &readlink imported?';
ok !defined(P5readlink::{'&readlink'}), '&readlink externally NOT accessible?';

is readlink("doesnotexist"), Nil, 'did we get a Nil on it non-existing?';
is readlink($?FILE), Nil, 'did we get a Nil on it not being a symlink?';

if $?FILE.IO.parent.IO.child("symlink").e {
    is readlink($?FILE.IO.parent.IO.child("symlink")), $?FILE.IO.basename,
      'did we get this file back as symlink on it?';
    given $?FILE.IO.parent.IO.child("symlink") {
        is readlink, $?FILE.IO.basename,
          'did we get this file back as symlink on $_?';
    }
}
else {
    pass 'symlinked directory entry does not exist, cannot test';
    pass 'symlinked directory entry does not exist, cannot test';
}

given "doesnotexist" {
    is readlink, Nil, 'did we get a Nil on $_ non-existing?';
}
given $?FILE {
    is readlink($?FILE), Nil, 'did we get a Nil on $_ not being a symlink?';
}

# vim: ft=perl6 expandtab sw=4
