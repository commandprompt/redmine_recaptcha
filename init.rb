# Rails plugin initialization.

require 'net/http'
require 'recaptcha'
require 'recaptcha/rails'
require 'recaptcha/client_helper'
require 'redmine'

Redmine::Plugin.register :redmine_recaptcha do
  name 'reCAPTCHA for user self registration'
  author 'Shane StClair'
  description 'Adds a recaptcha to the user self registration screen to combat spam'
  version '0.2.0'
  url 'http://github.com/srstclair/redmine_recaptcha'
  requires_redmine :version_or_higher => '2.0.0'
  settings :default => {
     'recaptcha_private_key' => '',
     'recaptcha_public_key' => ''
  }, :partial => 'settings/redmine_recaptcha'
end

require_dependency 'redmine_recaptcha/view_hooks'

prepare_block = Proc.new do
  AccountController.send(:include, RedmineRecaptcha::AccountControllerPatch)
end

if Rails.env.development?
  ActionDispatch::Reloader.to_prepare { prepare_block.call }
else
  prepare_block.call
end

