class HomepageController < ApplicationController
  def index
    @sentence_count = Sentence.count
    @bot_token_end = ENV['BOT_TOKEN'][-4..-1]
    @bot_name = ENV['BOT_USERNAME']
    @webhook = ENV['HOST']
    @webhook_response = params[:webhook_response]
  end

  def random_gif
    @gif_name = Sentence.order(Arel.sql("RANDOM()")).first.build_gif
  end

  def set_webhook
    respond_to do |f|
      f.html
      f.js do
        Rails.logger.info("Trying to set webhook")
        @response = system('rails telegram:bot:set_webhook')
        redirect_to root_path(webhook_response: @response)
      end
    end
  end
end
