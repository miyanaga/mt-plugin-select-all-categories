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
    $.fn.enforceToCheck = function(value) {
        var el = this;
        return el.each(function() {
            if ( $(this).prop('checked') \!= value ) {
                $(this).trigger('click');
            }
        });
    };

    var $selectAll = $('<a href="javascript:void(0)" style="float:left"><__trans phrase="Select All"></a>').click(function() {
            $('#category-selector-list .add-category-checkbox').enforceToCheck(true);
            return false;
        }), $unselectAll = $('<a href="javascript:void(0)" style="float:left; margin-left: 8px"><__trans phrase="Unselect All"></a>').click(function() {
            $('#category-selector-list .add-category-checkbox').enforceToCheck(false);
            return false;
        });
    var $controll = $('<div style="float: left; padding-bottom: 6px;"></div>').append($selectAll).append($unselectAll);
    $('#entry-category-widget .widget-content').prepend($controll);

    var hint = navigator.userAgent.indexOf('Mac') == -1 ?
        '<__trans phrase="Press Ctrl key to select or unselect the tree.">' :
        '<__trans phrase="Press command key to select or unselect the tree.">';
    $('#category-selector-list').after($('<div class="hint" style="width:100%">' + hint + '</div>'));

    $('input.add-category-checkbox').live('click',function(ev) {
        if ( ev.metaKey ) {

            var $listItem = $(this).closest('.list-item');
            var baseChecked = $(this).prop('checked');
            var $baseIndent = $listItem.children().first();
            var baseIndent = parseInt($baseIndent.css('margin-left'));

            var $current = $listItem.next();
            while( $current && $current.length > 0 ) {

                var $indent = $current.children().first();
                var indent = parseInt($indent.css('margin-left'));
                var $checkbox = $current.find('input.add-category-checkbox');
                var checked = $checkbox.prop('checked');

                if ( indent > baseIndent ) {
                    if ( baseChecked == checked ) {
                        // Do nothing
                    } else {
                        $checkbox.trigger('click');
                    }
                } else {
                    // Finish
                    break;
                }

                $current = $current.next();
            }
        }

        return true;
    });

})(jQuery);
</__trans_section>
    !);
    $tmpl->insertBefore($node, $tmpl->getElementById('footer_include'));

    1;
}

1;