package MT::SelectAllCategories::CMS;

use strict;
use warnings;

use MT::SelectAllCategories::Util;

sub template_param_edit_entry {
    my ( $ctx, $app, $param, $tmpl ) = @_;
    my $type = $param->{object_type} || $param->{class};

    return unless $type eq 'entry';

    my $node = $tmpl->createElement('setvarblock', { name => 'jq_js_include', append => 1 });
    $node->innerHTML(q!;
<__trans_section component="SelectAllCategories">
(function($) {
    var $selectAll = $('<a href="#" style="float:left"><__trans phrase="Select All"></a>').click(function() {
            $('#category-selector-list .add-category-checkbox').prop('checked', true);
        }), $unselectAll = $('<a href="#" style="float:left; margin-left: 8px"><__trans phrase="Unselect All"></a>').click(function() {
            $('#category-selector-list .add-category-checkbox').prop('checked', false);
        });
    $('.category-selector-header').prepend($unselectAll).prepend($selectAll);
})(jQuery);
</__trans_section>
    !);
    $tmpl->insertBefore($node, $tmpl->getElementById('footer_include'));

    1;
}

1;