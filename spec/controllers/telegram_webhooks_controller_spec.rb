require "rails_helper"
require 'telegram/bot/updates_controller/rspec_helpers'

RSpec.describe TelegramWebhooksController, type: :telegram_bot_controller do
  describe "inline_query" do

    subject { controller.inline_query(query, offset) }

    let(:query) {}
    let(:offset) {}

    context "when empty query" do
      let(:offset) { 0 }
      let(:query) { '' }

      it 'should answer with 3 results' do
        allow(controller).to receive(:answer_inline_query).with([{
            type: 'mpeg4_gif',
            id: '1234567',
            mpeg4_url: 'https://futurebots.it/plot-twist' + '/gif/domani_ti_spo.gif' # ,
            # thumb_url: [ENV['SERVER_URL'], 'placeholder.jpg'].join('/')
          }] , { next_offset: 0 })
        subject
      end
    end
  end
end
