$(document).on "page:change", ->
  $('#simple_sqls_table').dataTable
    columns: [ 
      { width: "null", searchable: true, orderable: true } 
      { width: "10%", searchable: false, orderable: false }  
      { width: "3%", searchable: false, orderable: false }  
      { width: "3%", searchable: false, orderable: false }
      { width: "3%", searchable: false, orderable: false }
    ] 
    retrieve: true
    aoColumnDefs: [{
          'bSortable': false,
          'aTargets': ['nosort']
      }]
    language: { url: "/Portuguese-Brazilian.json" }
    sPaginationType: "full_numbers"
    bProcessing: true
    bServerSide: true
    sAjaxSource: $('#simple_sqls_table').data('source')
