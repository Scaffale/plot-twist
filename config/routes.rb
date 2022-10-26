Rails.application.routes.draw do
  root 'homepage#index'
  get :random_gif, to: 'homepage#random_gif'
  telegram_webhook TelegramWebhooksController
end
