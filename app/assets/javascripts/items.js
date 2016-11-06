function Item(attributes) {
	this.description = attributes.description;
	this.id = attributes.id;
};

Item.success = function(json) {
	var item = new Item(json);
	var itemLi = item.renderLI();

	$("ul.todo-list").append(itemLi);
};

Item.error = function(response) {
	console.log("Broke", response);
};

Item.formSubmit = function(e) {
	e.preventDefault();
	var $form = $(this);
	var action = $form.attr("action");
	var params = $form.serialize();

	$.ajax({
		url: action,
		data: params,
		dataType: "json",
		method: "POST"
	})
	.success(Item.success)
	.error(Item.error)
};

$(function() {
	Item.templateSource = $("#item-template").html();
	Item.template = Handlebars.compile(Item.templateSource);
});

Item.prototype.renderLI = function() {
	return Item.template(this)
};


$(function() {
	$("form#new_item").on("submit", Item.formSubmit);
});