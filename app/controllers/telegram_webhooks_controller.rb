class TelegramWebhooksController < Telegram::Bot::UpdatesController
  def inline_query(query, offset)
    answer_inline_query {
        type: 'mpeg4_gif',
        # id: uniq_id(result.new_name(extra_params)),
        mpeg4_url: root_url + '/gif/domani_ti_spo.gif' # ,
        # thumb_url: [ENV['SERVER_URL'], 'placeholder.jpg'].join('/')
      }, 0
  end
end