$(function() {
	$("form#new_item").on("submit", function(e) {
		e.preventDefault();
		var $form = $(this);
		var action = $form.attr("action");
		var params = $form.serialize();

		$.post(action, params); // what do we want to do when the server responds to this ajax request?
	});
});