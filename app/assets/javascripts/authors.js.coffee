# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
	$(".authorTable").dataTable({
		"info": false,
		"bLengthChange": false,
		"aoColumns": [
	      null,
	      { "sWidth": "50%" },
	      { "sWidth": "8%", "sClass": "alignCenter" },
	      { "sWidth": "8%", "sClass": "alignCenter" }
	    ]
		
	});