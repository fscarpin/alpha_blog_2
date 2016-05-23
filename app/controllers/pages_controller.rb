class PagesController < ApplicationController

  def home
    # Redirect to articles list if the user is logged in
    redirect_to(articles_path) if logged_in?
  end

  def about

  end
end
