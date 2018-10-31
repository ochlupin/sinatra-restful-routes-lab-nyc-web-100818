require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

#loads index page, default route
  get '/' do
    erb :index
  end

# loads new form page to create a record
  get '/recipes/new' do
    erb :new
  end

#loads index page for recipes, uses ActiveRecord to get all instances of Recipe
  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

# loads show page for the Recipe record with :id
  get '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :show
  end

#loads edit form page, first step in the edit process
  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :edit
  end

# second step, uses ActiveRecord to update/patch the matching record
  patch '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect to "/recipes/#{@recipe.id}" # redirects to show page for the matching record
  end

#uses ActiveRecord to create a new record and redirects to show page for that record after
  post '/recipes' do
    @recipe = Recipe.create(params)
    redirect to "/recipes/#{@recipe.id}"
  end

#uses ActiveRecord to delete a reocrd and redirects to index page after
  delete '/recipes/:id/delete' do
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.delete
    redirect to '/recipes'
  end

end
