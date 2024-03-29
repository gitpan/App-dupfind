# ABSTRACT: Map-reduce version of digest_dups method and worker thread for it

use strict;
use warnings;

package App::dupfind::Threaded::MapReduce::Digest;
{
  $App::dupfind::Threaded::MapReduce::Digest::VERSION = '0.140230'; # TRIAL
}

use 5.010;

use threads;
use threads::shared;

use Moo::Role;

use Time::HiRes 'usleep';
use Digest::xxHash 'xxhash_hex';

requires 'opts';

my $read_semaphore :shared;

sub digest_dups
{
   my ( $self, $size_dups ) = @_;

   # you have to do this for this threaded version of dupfind, and it has
   # to happen after you've already pruned out the hardlinks

   # don't bother to hash zero-size files

   my $zero_digest = xxhash_hex '', 0;

   my $zero_files  = delete $size_dups->{0};

   my $map_code    = sub { $self->_digest_worker( @_ ) };

   my $reduced     = $self->map_reduce( $size_dups => $map_code );

   $reduced->{ $zero_digest } = $zero_files if ref $zero_files;

   return $reduced;
}

# !! The code to be mapped MUST increment $self->counter for each item it sees
sub _digest_worker
{
   my $self = shift;

   my $digest_cache  = {};
   my $cache_stop    = $self->opts->{cachestop};
   my $max_cache     = $self->opts->{cachesize};
   my $ram_caching   = !! $self->opts->{ramcache};
   my $cache_size    = 0;
   my $cache_hits    = 0;
   my $cache_misses  = 0;

   local $/;

   WORKER: while
   (
       ! $self->term_flag
      && defined ( my $grouping = $self->work_queue->dequeue )
   )
   {
      my $data;

      GROUPING: for my $file ( @$grouping )
      {
         my $size = -s $grouping->[0];
         my $digest;

         open my $fh, '<', $file or do
            {
               $self->increment_counter;

               next GROUPING;
            };

         READ_LOCK:
         {
            lock $read_semaphore;

            $data = <$fh>;
         }

         close $fh;

         if ( $ram_caching )
         {
            if ( $digest = $digest_cache->{ $data } )
            {
               $cache_hits++;
            }
            else
            {
               if ( $cache_size < $max_cache && $size <= $cache_stop )
               {
                  $digest_cache->{ $data } = $digest = xxhash_hex $data, 0;

                  $cache_size++;

                  $cache_misses++;
               }
               else
               {
                  $digest = xxhash_hex $data, 0;
               }
            }
         }
         else
         {
            $digest = xxhash_hex $data, 0;
         }

         $self->push_mapped( $digest => $file );

         $self->increment_counter;
      }

      $digest_cache = {}; # it's only worthwhile per-size-grouping
      $cache_size   = 0;

      $self->add_stats( cache_hits   => $cache_hits );
      $self->add_stats( cache_misses => $cache_misses );
   }
}

1;

__END__

=pod

=head1 NAME

App::dupfind::Threaded::MapReduce::Digest - Map-reduce version of digest_dups method and worker thread for it

=head1 VERSION

version 0.140230

=head1 DESCRIPTION

Overrides the digest_dups method from App::dupfind::Common and implements an worker
thread routine that is invoked therein.  In this threaded version of digest_dups,
the set of same-size file groupings is mapped as a task and sent to the main
map reducer logic engine implemented in App::dupfind::Threaded::MapReduce.  The
outcome of that multithreaded map-reduce operation is a list of true duplicates
(or no duplicates if none were found).

Please don't use this module by itself.  It is for internal use only.

=head1 METHODS

=over

=item digest_dups

Calls the map-reduce logic on the $size_dups hashref, providing a wrapped
coderef calling out to _digest_worker that will be invoked by the map-reduce
engine for same-size size file groupings

This overrides the digest_dups method in App::dupfind::Common

=item _digest_woker

Does the calculating of digests in order to determine uniqueness of files in
a same-size file grouping, storing information in a shared hashref and
recording statistics as it progresses.  A caching mechanism is used in order
to avoid re-hashing of file content that has already been seen, yielding a
very consequential performance gain.

=back

=cut
