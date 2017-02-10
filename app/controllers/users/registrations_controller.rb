class Users::RegistrationsController < Devise::RegistrationsController
  before_action :select_plan, only: :new
  
  # Extend default devise gem behaviour so that users signing up with the Pro
  # account (plan ID 2) save with a special stripe subscription function
  # Otherwise Devise signs up user as usual
  def create
    super do |resource|
      if params[:plan]
        resource.plan_id = params[:plan]
        if resource.plan_id == 2
          resource.save_with_subscription
        else
          resource.save
        end
      end
    end
  end
  
  # User has to select basic (plan ID 1) or pro (plan ID 2) to sign up
  # Can't access sign up page from /sign_up.../sign_up?plan=5...etc
  private
    def select_plan
      unless(params[:plan] == '1' || params[:plan] == '2')
        flash[:notice] = "Please select a membership plan to sign up."
        redirect_to root_path
      end
    end
end