class RecipesController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_filter  :verify_authenticity_token

  def index
    @recipes = Recipe.all
    render json: @recipes
    # respond_to do |format|
    #   format.html { render :index }
    #   format.json { render json: @recipes }
    # end
  end

  def show
    @recipe = Recipe.find_by(id: params[:id])
    if @recipe
      render json: @recipe
    else
      render json: "recipe does not exist"
    end
  end

  def create
    @recipe = Recipe.create(recipe_params)
    if @recipe.save
      render json: @recipe
    else
      render json: "there was an error in creating your recipe"
    end
  end

  def update
    @recipe = Recipe.find_by(id: params[:id])
    if @recipe.update(recipe_params)
      render json: @recipe
    else
      render json: "there was an error updating your recipe"
    end
  end

  def destroy
    @recipe = Recipe.find_by(id: params[:id])
    if @recipe
      @recipe.destroy
      msg = {msg: "receipe removed from API"}
      render json: { body: msg }
    else
      render json: "there was an error removing your recipe"
    end
  end

  private
  def recipe_params
    params.require(:recipe).permit(:name, :ingredients, :instructions)
  end

end
