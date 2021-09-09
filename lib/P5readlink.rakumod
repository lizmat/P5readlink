use v6.d;

unit module P5readlink:ver<0.0.9>:auth<zef:lizmat>;

proto sub readlink(|) is export {*}
multi sub readlink(--> Str:D) {
    readlink(CALLERS::<$_>)
}
multi sub readlink(Str() $path --> Str:D) {
    use nqp;  # readlink functionality only exposed as nqp ops
    nqp::stat($path,nqp::const::STAT_EXISTS) && nqp::fileislink($path)
      ?? nqp::readlink($path)
      !! Nil
}

=begin pod

=head1 NAME

Raku port of Perl's readlink() built-in

=head1 SYNOPSIS

  use P5readlink;

  say readlink("foobar"); # string if symlink, Nil if not

  with "foobar" {
      say readlink; # string if symlink, Nil if not
  }

=head1 DESCRIPTION

This module tries to mimic the behaviour of Perl's C<readlink> built-in
as closely as possible in the Raku Programming Language.

=head1 ORIGINAL PERL DOCUMENTATION

    readlink EXPR
    readlink
            Returns the value of a symbolic link, if symbolic links are
            implemented. If not, raises an exception. If there is a system
            error, returns the undefined value and sets $! (errno). If EXPR is
            omitted, uses $_.

            Portability issues: "readlink" in perlport.

=head1 PORTING CAVEATS

=head2 $! not always set

Currently C<$!> is B<not> set when Nil is returned.

=head2 $_ no longer accessible from caller's scope

In future language versions of Raku, it will become impossible to access the
C<$_> variable of the caller's scope, because it will not have been marked as
a dynamic variable.  So please consider changing:

    readlink;

to either:

    readlink($_);

or, using the subroutine as a method syntax, with the prefix C<.> shortcut
to use that scope's C<$_> as the invocant:

    .&readlink;

=head1 AUTHOR

Elizabeth Mattijsen <liz@raku.rocks>

Source can be located at: https://github.com/lizmat/P5readlink . Comments and
Pull Requests are welcome.

=head1 COPYRIGHT AND LICENSE

Copyright 2018, 2019, 2020, 2021 Elizabeth Mattijsen

Re-imagined from Perl as part of the CPAN Butterfly Plan.

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod

# vim: expandtab shiftwidth=4
