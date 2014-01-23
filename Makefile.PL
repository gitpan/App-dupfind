
use strict;
use warnings;

use 5.010;

use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "Composed class exposing the App::dupfind iface, used in \$bin/dupfind",
  "AUTHOR" => "Tommy Butler <devnull\@internetalias.net>",
  "BUILD_REQUIRES" => {
    "Module::Build" => "0.3601"
  },
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30",
    "Module::Build" => "0.3601"
  },
  "DISTNAME" => "App-dupfind",
  "EXE_FILES" => [
    "bin/dupfind"
  ],
  "LICENSE" => "perl",
  "NAME" => "App::dupfind",
  "PREREQ_PM" => {
    "Benchmark" => 0,
    "Digest::xxHash" => 0,
    "File::Util" => 0,
    "Getopt::Long" => 0,
    "Moo" => 0,
    "Moo::Role" => 0,
    "Pod::Usage" => 0,
    "Term::ProgressBar" => 0,
    "Term::Prompt" => 0,
    "Thread::Queue" => 0,
    "Time::HiRes" => 0,
    "lib" => 0,
    "strict" => 0,
    "threads" => 0,
    "threads::shared" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "Benchmark" => 0,
    "Digest::xxHash" => 0,
    "ExtUtils::MakeMaker" => 0,
    "File::Spec" => 0,
    "File::Temp" => 0,
    "File::Util" => 0,
    "Getopt::Long" => 0,
    "IO::Handle" => 0,
    "IPC::Open3" => 0,
    "Module::Build" => "0.3601",
    "Moo" => 0,
    "Moo::Role" => 0,
    "Pod::Usage" => 0,
    "Storable" => 0,
    "Test" => 0,
    "Test::More" => "0.88",
    "Test::NoWarnings" => 0,
    "Thread::Queue" => 0,
    "Time::HiRes" => 0,
    "Try::Tiny" => 0,
    "threads" => 0,
    "threads::shared" => 0
  },
  "VERSION" => "0.140230",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Benchmark" => 0,
  "Digest::xxHash" => 0,
  "ExtUtils::MakeMaker" => 0,
  "File::Spec" => 0,
  "File::Temp" => 0,
  "File::Util" => 0,
  "Getopt::Long" => 0,
  "IO::Handle" => 0,
  "IPC::Open3" => 0,
  "Module::Build" => "0.3601",
  "Moo" => 0,
  "Moo::Role" => 0,
  "Pod::Usage" => 0,
  "Storable" => 0,
  "Term::ProgressBar" => 0,
  "Term::Prompt" => 0,
  "Test" => 0,
  "Test::More" => "0.88",
  "Test::NoWarnings" => 0,
  "Thread::Queue" => 0,
  "Time::HiRes" => 0,
  "Try::Tiny" => 0,
  "lib" => 0,
  "strict" => 0,
  "threads" => 0,
  "threads::shared" => 0,
  "warnings" => 0
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



