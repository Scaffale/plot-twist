class HomepageController < ApplicationController
  def index
    @sentence_count = Sentence.count
    @bot_token_end = ENV['BOT_TOKEN'][-4..-1]
    @bot_name = ENV['BOT_USERNAME']
    @webhook = ENV['HOST']
  end

  def random_gif
    @gif_name = Sentence.order(Arel.sql("RANDOM()")).first.build_gif
  end
end
