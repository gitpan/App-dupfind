use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::NoTabsTests 0.06

use Test::More 0.88;
use Test::NoTabs;

my @files = (
    'bin/dupfind',
    'lib/App/dupfind.pm',
    'lib/App/dupfind/App.pm',
    'lib/App/dupfind/Common.pm',
    'lib/App/dupfind/Guts.pm',
    'lib/App/dupfind/Guts/Algorithms.pm',
    'lib/App/dupfind/Threaded.pm',
    'lib/App/dupfind/Threaded/MapReduce.pm',
    'lib/App/dupfind/Threaded/MapReduce/Digest.pm',
    'lib/App/dupfind/Threaded/MapReduce/Weed.pm',
    'lib/App/dupfind/Threaded/Overrides.pm',
    'lib/App/dupfind/Threaded/ThreadManagement.pm'
);

notabs_ok($_) foreach @files;
done_testing;
