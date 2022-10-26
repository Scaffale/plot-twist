class HomepageController < ApplicationController
  def index
  end

  def random_gif
    @gif_name = Sentence.order(Arel.sql('RANDOM()')).first.build_gif

  end
end
