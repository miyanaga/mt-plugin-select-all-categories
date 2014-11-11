package MT::SelectAllCategories::Util;

use strict;
use warnings;

use base qw(Exporter);
our @EXPORT = qw(plugin pp);

use Data::Dumper;

sub plugin { MT->component('SelectAllCategories') }

sub pp { print STDERR Dumper($_) foreach @_ }

1;