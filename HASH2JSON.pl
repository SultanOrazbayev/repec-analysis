#!/usr/bin/perl -w
use strict;

use utf8;
use JSON;

#check if command line argument exist
die "Usage: $0 file_name_with_hash\n" unless @ARGV >= 1;
my $filename = $ARGV[0];

# reading file with hash
open my $in, '<', $filename or die $!; # open file handle or exit with error
my $data;
{
    local $/;    # slurp mode
    $data = <$in>; # reading whole file to variable
}
close $in; # close file handle

# skip first 2 lines as unnecessary
$data =~ s/^(?:.*\n){1,2}//;

# replace hash statement with reference to comply Perl hash structure
$data =~ s/^\%relatedworks\ \=\ \(/\$sf\=\{/mg;

# replace brackets to comply Perl hash structure
$data =~ s/^\)\;/\}\;/mg;

my $sf; # define $sf as reference to hash
eval $data; # place hash from file to $sf

# writing result hash to file
open my $fh, ">", "data_out.json";
print $fh encode_json($sf);
close $fh;
