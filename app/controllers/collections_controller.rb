class CollectionsController < AuthenticatedController
	require 'securerandom'
	
	def index
		@custom_collections = ShopifyAPI::CustomCollection.find(:all)
    	@smart_collections = ShopifyAPI::SmartCollection.find(:all)
	end
	def show
		@type = params[:type]
		if params[:type] == 'smart'
			@collection = ShopifyAPI::SmartCollection.find(params[:id])	
		elsif params[:type] == 'custom'
			@collection = ShopifyAPI::CustomCollection.find(params[:id])
		end
		@blocks = ShopifyAPI::Metafield.find(:all, :params =>{:resource => 'collections', :resource_id => @collection.id, :namespace => 'block'})
		@products = ShopifyAPI::Product.find(:all, :params => {:collection_id => @collection.id, :fields => ['title', 'images', 'id']})
		@config = ShopifyAPI::Metafield.find(:first, :params =>{:resource => 'collections', :resource_id => @collection.id, :namespace => 'config'})
		if @config.present?
			config_val = @config.value.split(';;')
			@background_color = config_val[0] 
			@text_color = config_val[1]
		end 
	end

	def destroy
		if params[:type] == 'smart'
			@collection = ShopifyAPI::SmartCollection.find(params[:collection])	
		elsif params[:type] == 'custom'
			@collection = ShopifyAPI::CustomCollection.find(params[:collection])
		end
		metafield = ShopifyAPI::Metafield.find(params[:id])
		metafield.destroy
		redirect_to collection_path(@collection, type: params[:type])
	end

	def block
		@block_type = params[:block_type]
		@collection = params[:collection]
		@type = params[:type]
		respond_to do |format|               
		   format.js
		 end 
	end
	def add_image
		if params[:type] == 'smart'
			@collection = ShopifyAPI::SmartCollection.find(params[:collection])	
		elsif params[:type] == 'custom'
			@collection = ShopifyAPI::CustomCollection.find(params[:collection])
		end
		@images = params[:images]
		@random_string = SecureRandom.hex(5)
		@collection.add_metafield(ShopifyAPI::Metafield.new(namespace: 'block', key: @random_string,  value: @images + ';;' + params[:block_type], value_type: "string"))
		redirect_to collection_path(@collection)
	end
	def update_config
		@data = params[:config_data]
		if params[:type] == 'smart'
			@collection = ShopifyAPI::SmartCollection.find(params[:collection])	
		elsif params[:type] == 'custom'
			@collection = ShopifyAPI::CustomCollection.find(params[:collection])
		end
		@collection.add_metafield(ShopifyAPI::Metafield.new(namespace:'config', key: @collection.id,  value: @data, value_type: "string"))
		redirect_to collection_path(@collection)
	end
end
