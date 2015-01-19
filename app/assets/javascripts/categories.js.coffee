# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
	$(".categoryTable").dataTable({
		info: false
		bProcessing: true
		bServerSide: true
		sAjaxSource: $('.categoryTable').data('source')
		bLengthChange: false
		aaSorting: [[0, 'asc']]		
		aoColumns: [
	      null,
	      { "sWidth": "8%", "sClass": "alignCenter", "bSortable": false },
	      { "sWidth": "8%", "sClass": "alignCenter", "bSortable": false }
	    ]
	});