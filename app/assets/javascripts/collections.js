var CollectionsController = Paloma.controller('Collections', {
	show: function(){
		console.log('show page');
		var blockOptions = {
			container: 'grid'
		}
		$('[data-trigger=new-block]').on('click', function(){
			new App.addBlock(blockOptions);
		})

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
	return '<div class="block-select"><span>block 1</span><span>block 2</span><span>block 3</span></div>'
}
