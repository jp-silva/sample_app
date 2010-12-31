class TestController < ActionController::Base
  def upload_action
    # Do stuff with params[:uploaded_file]

    responds_to_parent do
      render :update do |page|
        page.replace_html 'upload_form', :partial => 'upload_form'
      end
    end
  end
end