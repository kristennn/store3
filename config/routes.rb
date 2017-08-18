Rails.application.routes.draw do
  devise_for :users
  root "products#index"
  resources :products do
    resources :reviews
    collection do
      get :search
    end
    member do
      post :add_to_cart
    end
  end
  namespace :admin do
    resources :products
    resources :orders do
      member do
        post :ship
        post :deliver
        post :return
        post :cancel
      end
    end
  end
  resources :carts do
    collection do
      delete :clean
      post :checkout
    end
  end
  resources :cart_items
  resources :orders do
    member do
      post :pay_with_alipay
      post :pay_with_wechat
    end
  end
  namespace :account do
    resources :orders
  end
end
