# ABSTRACT: Methods and attributes that have to be overridden when threading

# Overriding from:
#  - App::dupfind::Common
#  - App::dupfind::Guts

use strict;
use warnings;

package App::dupfind::Threaded::Overrides;
{
  $App::dupfind::Threaded::Overrides::VERSION = '0.140230'; # TRIAL
}

use 5.010;

use threads;
use threads::shared;

use Moo::Role;

use lib 'lib';

requires 'opts';

{
   my $stats = {}; &share( $stats );

   sub stats
   {
      my ( $self, $key, $val ) = @_;

      return $stats unless $key;

      lock $stats;

      $stats->{ $key } = $val;
   }

   sub add_stats
   {
      my ( $self, $key, $val ) = @_;

      return $stats unless $key;

      lock $stats;

      $stats->{ $key } += $val;
   }
}

sub sort_dups
{
   my ( $self, $dups ) = @_;

   # sort dup groupings
   for my $identifier ( keys %$dups )
   {
      my @group = @{ $dups->{ $identifier } };

      $dups->{ $identifier } = &shared_clone( [ sort { $a cmp $b } @group ] );
   }

   return $dups;
}

1;

__END__

=pod

=head1 NAME

App::dupfind::Threaded::Overrides - Methods and attributes that have to be overridden when threading

=head1 VERSION

version 0.140230

=head1 DESCRIPTION

Some of the methods in App::dupfind::Common and App::dupfind::Guts need to
be overridden here in order to make thread-safe versions of them, and/or
versions of the methods that implement support for shared variables that
will be passed around between threads during the map-reduce operations
implemented by App::dupfind::Threaded::MapReduce

Please don't use this module by itself.  It is for internal use only.

Because there are no functional differences between these methods and the
ones they override, please refer to the original documentation for them in
the POD of these classes:

=over

=item *

=back

=head1 METHODS THIS CLASS OVERRIDES

=over

=item add_stats

Not overridden, but necessary in order to implement the simple hashref of
stats that is used in the non-threaded version in App::dupfind::Common.
$self->add_stats allows App::dupfind::Threaded::MapReduce::Digest to
accomplish the same thing, but in a thread-safe way.

The stats mechanism is simply there to keep track of cache hits and misses
while calculating file digests.

=item sort_dups

Overridden from App::dupfind::Common

=item stats

The sibling method to add_stats.  The same concept and description applies
(see above).

=back

=cut
