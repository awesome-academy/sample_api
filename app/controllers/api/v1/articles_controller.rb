class Api::V1::ArticlesController < ApplicationController

  def show
    @article = Article.find_by id: params[:id]
    render json: @article
  end

 end
