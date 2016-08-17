var CollectionsController = Paloma.controller('Collections', {
	show: function(){
		var blockOptions = {
			container: 'grid'
		}
		$('[data-trigger]').on('click', function(){	
			var block = $(this).data('trigger')
			new App.addBlock(blockOptions, block);
		})
		$('body').on('click', '[data-block]', function(event){
			var block = $(this).data('block')
			App.createBlock(block)
		})

		$('body').on('click', '.icon-photos', function(){
			var block = $(this).parent()
			$('#image-gallery').toggleClass('hidden').data('block', block)

		});	
		$('body').on('click', '#image-gallery img', function(){
			var img = $(this).attr('src') + ':::' + $(this).data('producttitle') + ':::' + $(this).data('productid')
			var block = $('#image-gallery').data('block')
			$(block).data('image', img).css('background', 'url(' + img + ')')
			
		});

		

	}, 
	index: function(){
		console.log('index page');
	}
});


window.App = {}

window.App.addBlock = function(options, block){
	var container = options.container;
	$('#' + container).append(App.Blocks[block]());
}


App.Blocks = {
	block1: function(){
		return '<section><div class="card"><div class="flex-container"><div class="half"></div><div class="half"><div class="quarter"></div><div class="quarter"></div></div></div></div></section>'
	}, 
	block2: function(){
		return '<section><div class="card"><div class="flex-container"><div class="third"></div><div class="third"></div><div class="third"></div></div></div></section>'
	}, 
	block3: function(){
		return '<section><div class="card"><div class="flex-container"><div class="half"></div><div class="half"></div></div></div></section>'
	}
}














