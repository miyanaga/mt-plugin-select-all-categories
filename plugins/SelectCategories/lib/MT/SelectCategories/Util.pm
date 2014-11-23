package MT::SelectCategories::Util;

use strict;
use warnings;

use base qw(Exporter);
our @EXPORT = qw(plugin pp);

use Data::Dumper;

sub plugin { MT->component('SelectCategories') }

sub pp { print STDERR Dumper($_) foreach @_ }

1;