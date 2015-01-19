# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
	$(".authorTable").dataTable({
		info: false
		bProcessing: true
		bServerSide: true
		sAjaxSource: $('.authorTable').data('source')
		bLengthChange: false
		aaSorting: [[0, 'asc']]
		aoColumns: [
	      null,
	      { "sWidth": "50%" },
	      { "sWidth": "8%", "sClass": "alignCenter", "bSortable": false },
	      { "sWidth": "8%", "sClass": "alignCenter", "bSortable": false }
	    ]
		
	});