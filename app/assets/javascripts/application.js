// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require jquery.ui.datepicker
//= require dataTables/jquery.dataTables
//= require dataTables/jquery.dataTables.bootstrap
//= require jquery_nested_form
//= require rails.validations
//= require rails.validations.nested_form
//= require select2
//= require_tree ../../../vendor/assets/javascripts
//= require_tree .
//= require blueimp-gallery-all
//

// Set up our EA namespace for our functions
var EA = {};
EA.onRailsPage = function(railsController, railsActions) {
  var selector = _.map(railsActions, function(action) {
    return "body." + railsController + "." + action;
  }).join(', ');


  return $(selector).length > 0;
}

$(function(){

    $('tr[data-link]').click(function(){
      window.location = this.dataset.link
    });

    $('tr[data-link]').hover(
      function(){
        $(this).css("background", "yellow");
        $(this).css("cursor", "pointer");
      },
      function(){
        $(this).css("background", "");
      }
    );
    
    $('.display').dataTable( {
        //"sDom": "<'row'<'span7'lf>r>t<'row'<'span7'ip>>",
        "sDom": '<"top"ifp<"clear">>rt<"bottom"<"clear">>',
        "sPaginationType": "bootstrap"
    } );

    $(document).ready(function(){
      $('form').attr('autocomplete', 'off');

      $('select').keypress(function(event) 
        { return cancelBackspace(event) });
      $('select').keydown(function(event) 
        { return cancelBackspace(event) });
    });

    function cancelBackspace(event) {
      if (event.keyCode == 8) {
        return false;
      }
    }

});
