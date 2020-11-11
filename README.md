NAME
====

Raku port of Perl's readlink() built-in

SYNOPSIS
========

    use P5readlink;

    say readlink("foobar"); # string if symlink, Nil if not

    with "foobar" {
        say readlink; # string if symlink, Nil if not
    }

DESCRIPTION
===========

This module tries to mimic the behaviour of Perl's `readlink` built-in as closely as possible in the Raku Programming Language.

ORIGINAL PERL DOCUMENTATION
===========================

    readlink EXPR
    readlink
            Returns the value of a symbolic link, if symbolic links are
            implemented. If not, raises an exception. If there is a system
            error, returns the undefined value and sets $! (errno). If EXPR is
            omitted, uses $_.

            Portability issues: "readlink" in perlport.

PORTING CAVEATS
===============

$! not always set
-----------------

Currently `$!` is **not** set when Nil is returned.

$_ no longer accessible from caller's scope
-------------------------------------------

In future language versions of Raku, it will become impossible to access the `$_` variable of the caller's scope, because it will not have been marked as a dynamic variable. So please consider changing:

    readlink;

to either:

    readlink($_);

or, using the subroutine as a method syntax, with the prefix `.` shortcut to use that scope's `$_` as the invocant:

    .&readlink;

AUTHOR
======

Elizabeth Mattijsen <liz@wenzperl.nl>

Source can be located at: https://github.com/lizmat/P5readlink . Comments and Pull Requests are welcome.

COPYRIGHT AND LICENSE
=====================

Copyright 2018-2020 Elizabeth Mattijsen

Re-imagined from Perl as part of the CPAN Butterfly Plan.

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

