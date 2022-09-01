class PagesController < ApplicationController
    before_action :authenticate_user!, only: [:profile]

    def profile
        @user = current_user
    end

    def home

    end

    def faq
    
    end
    
end