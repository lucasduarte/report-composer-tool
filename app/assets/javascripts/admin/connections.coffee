# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on "page:change", ->
  $('#connections_table').dataTable
    columns: [ 
      { width: "10%", searchable: true, orderable: true } 
      { width: "10%", searchable: true, orderable: true } 
      { width: "null", searchable: true, orderable: false } 
      { width: "5%", searchable: false, orderable: false } 
      { width: "3%", searchable: false, orderable: false }  
      { width: "3%", searchable: false, orderable: false }
      { width: "3%", searchable: false, orderable: false }
    ] 
    retrieve: true
    aoColumnDefs: [{
          'bSortable': false,
          'aTargets': ['nosort']
      }]
    language: {
                "url": "//cdn.datatables.net/plug-ins/1.10.9/i18n/Portuguese-Brasil.json"
            }  
    sPaginationType: "full_numbers"
    bProcessing: true
    bServerSide: true
    sAjaxSource: $('#connections_table').data('source')
