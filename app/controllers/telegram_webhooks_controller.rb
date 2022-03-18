class TelegramWebhooksController < Telegram::Bot::UpdatesController
  def inline_query(query, offset)
    result = [{
        type: 'mpeg4_gif',
        id: '1234567',
        mpeg4_url: 'temp' + '/gif/domani_ti_spo.gif' # ,
        # thumb_url: [ENV['SERVER_URL'], 'placeholder.jpg'].join('/')
      }]
    answer_inline_query(result, { next_offset: 0 })
  end
end
