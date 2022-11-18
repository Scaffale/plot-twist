Rails.application.routes.draw do
  mount Lockup::Engine, at: '/lockup'

  root 'homepage#index'

  controller :homepage do
    get :random_gif
    get :set_webhook
    post :set_webhook
  end

  telegram_webhook TelegramWebhooksController
end
