# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
	$(".bookTable").dataTable
        info: false
        bProcessing: true
        bServerSide: true
        sAjaxSource: $('.bookTable').data('source')
        bLengthChange: false
        aaSorting: [[1, 'asc']]
        aoColumns: [
            {"sWidth": "20%", "bSortable": false },
            null,
            {"sWidth": "10%", "bSearchable": false},
            {"sWidth": "20%", "bSortable": false , "bSearchable": false},
            { "sWidth": "8%", "sClass": "alignCenter", "bSortable": false, "bSearchable": false },
            { "sWidth": "8%", "sClass": "alignCenter", "bSortable": false, "bSearchable": false }
        ]

	$('.chxBook').click ->
		$('.btnDelete')
			.attr("disabled", !$('.chxBook').is(":checked"))