var CollectionsController = Paloma.controller('Collections', {
	show: function(){
		console.log('show page');
		var blockOptions = {
			container: 'grid'
		}
		new App.addBlock(blockOptions);

	}, 
	index: function(){
		console.log('index page');
	}
});


window.App = {}

window.App.addBlock = function(options){
	var container = options.container;
	$('#' + container).append(App.createBlock());
}

App.createBlock = function(){
	return '<h2>block</h2>'
}
