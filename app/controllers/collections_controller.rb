class CollectionsController < AuthenticatedController
	def index
		@custom_collections = ShopifyAPI::CustomCollection.find(:all)
    	@smart_collections = ShopifyAPI::SmartCollection.find(:all)
	end
	def show
		if params[:type] == 'smart'
			@collection = ShopifyAPI::SmartCollection.find(params[:id])	
		elsif params[:type] == 'custom'
			@collection = ShopifyAPI::CustomCollection.find(params[:id])
		end
	end
end
