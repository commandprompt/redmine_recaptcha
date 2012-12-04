module RedmineRecaptcha
  class ViewHooks < Redmine::Hook::ViewListener
    render_on :view_account_register_extra_fields,
      :partial => 'hooks/recaptcha_extra_fields'
  end
end
