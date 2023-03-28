class ApplicationController < ActionController::Base
    rescue_from ActiveRecord::RecordNotFound, with: :id_not_found
    def id_not_found
        # render html: "Fail!!!"
        render file:Rails.root.join('public', '404.html'), layout: false, status: 404 and return 
    end
end
