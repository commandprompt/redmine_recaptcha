module RedmineRecaptcha
  module AccountControllerPatch
    unloadable

    def self.included(base)
      base.send(:include, InstanceMethods)

      base.class_eval do
        alias_method_chain :register, :recaptcha_verification
      end
    end
    
    module InstanceMethods
      def register_with_recaptcha_verification
        unless request.get?
          unless verify_recaptcha(:private_key => Setting.plugin_redmine_recaptcha['recaptcha_private_key'])
            user_params = params[:user] || {}
            @user = User.new
            @user.safe_attributes = user_params
            flash.now[:error] = "There was an error with the recaptcha code below. Please re-enter the code and click submit."
            return render :action => 'register'
          end
        end
        register_without_recaptcha_verification
      end
    end
  end
end
