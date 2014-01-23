
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  "build_requires" => {
    "Module::Build" => "0.3601"
  },
  "configure_requires" => {
    "ExtUtils::MakeMaker" => "6.30",
    "Module::Build" => "0.3601"
  },
  "dist_abstract" => "Composed class exposing the App::dupfind iface, used in \$bin/dupfind",
  "dist_author" => [
    "Tommy Butler <devnull\@internetalias.net>"
  ],
  "dist_name" => "App-dupfind",
  "dist_version" => "0.140230",
  "license" => "perl",
  "module_name" => "App::dupfind",
  "recommends" => {},
  "recursive_test_files" => 1,
  "requires" => {
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
    "perl" => "5.010",
    "strict" => 0,
    "threads" => 0,
    "threads::shared" => 0,
    "warnings" => 0
  },
  "script_files" => [
    "bin/dupfind"
  ],
  "test_requires" => {
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
    "perl" => "5.010",
    "threads" => 0,
    "threads::shared" => 0
  }
);


my %fallback_build_requires = (
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
  "perl" => "5.010",
  "threads" => 0,
  "threads::shared" => 0
);


unless ( eval { Module::Build->VERSION(0.4004) } ) {
  delete $module_build_args{test_requires};
  $module_build_args{build_requires} = \%fallback_build_requires;
}

my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
