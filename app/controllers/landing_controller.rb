class LandingController < ApplicationController
  def index
    @dog_breed = 'Irish setter'
    @result = 2 * 2
  end
end
