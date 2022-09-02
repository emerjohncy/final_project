class PagesController < ApplicationController
    before_action :authenticate_user!, only: [:profile, :buying_selling]

    def profile
        @user = current_user
    end

    def home

    end

    def faq
    
    end

    def buying_selling
        @user = current_user
    end
    
end