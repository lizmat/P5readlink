use v6.*;
use Test;
use P5readlink;

plan 12;

ok defined(::('&readlink')),            'is &readlink imported?';
ok !defined(P5readlink::{'&readlink'}), '&readlink externally NOT accessible?';

is readlink("doesnotexist"), Nil, 'did we get a Nil on path not existing?';
is readlink($?FILE), Nil, 'did we get a Nil on path not being a symlink?';

my $symlink = $?FILE.IO.parent.IO.child("symlink");
my $doesnotexist = $?FILE.IO.parent.IO.child("doesnotexist");
unlink $symlink;
nok $symlink.e, 'is there no "symlink" anymore?';

LEAVE unlink $symlink;
ok symlink($?FILE, $symlink), 'create the symlink';

is readlink($symlink), $?FILE, 'did we get this file back as symlink on it?';
given $symlink {
    is .&readlink, $?FILE, 'did we get this file back as symlink on $_?';
}

given "doesnotexist" {
    is .&readlink, Nil, 'did we get a Nil on $_ non-existing?';
}
given $?FILE {
    is readlink($?FILE), Nil, 'did we get a Nil on $_ not being a symlink?';
}

unlink $symlink;
ok symlink($doesnotexist, $symlink), 'create the symlink with a non-existant target';
given $symlink {
    is .&readlink, $doesnotexist, "did we get the target back if it's pointing somewhere non-existant?";
}


# vim: expandtab shiftwidth=4
