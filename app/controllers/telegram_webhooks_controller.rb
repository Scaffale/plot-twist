class TelegramWebhooksController < Telegram::Bot::UpdatesController
  def inline_query(query, offset)
    result = [{
        type: 'mpeg4_gif',
        id: '1234567',
        mpeg4_url: 'https://futurebots.it/plot-bot' + '/gif/dom_ti_spo.gif',
        thumb_url: 'https://futurebots.it/plot-bot' + '/placeholder.jpeg'
      }]
    answer_inline_query(result, { next_offset: 0 })
  end
end
