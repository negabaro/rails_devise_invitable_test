# frozen_string_literal: true

class DeviseMailer < Devise::Mailer
  #layout 'custom_users'
  # helper :application
  include Devise::Controllers::UrlHelpers
  #layout 'mailer'

  #default template_path: 'devise/mailer'
  # def headers_for(action, opts)
  #   #binding.pry
  #   #app/views/custom_users/mailer/invitation_instructions.html.erb
  #   #super.merge!({template_path: '/custom_users/mailer'})
  #   #super.merge!(template_path: ['/custom_users/mailer'], template_name: 'hoge')
  #   
  # end
  def headers_for(action, opts)
    #binding.pry
    #super
    super.merge!({template_path: '/hoge/keke'}) # <<動作する
    # super.merge!({template_path: '/hoge/keke2'})
    # super.merge!({template_path: ["devise_mailer", "/hoge/keke"] })
    
  end

  #helper :application # gives access to all helpers defined within `application_helper`.
  #include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  # default template_path: 'devise/mailer' # to make sure that your mailer uses the devise views

  def invitation_instructions(record, token, opts={})
    # binding.pry
    # super.merge!(template_path: 'devise/mailer')
    opts[:subject] = "xxxxxxxxxxxx22  has invited you to their Dashboard! Instructions inside!"

    super
  end

  def reset_password_instructions(record, token, opts = {})
    return unless record
    if record.instance_of?(Member)
      Users::MailSender.reset_password_instructions(record, token)
    else
      Mail::WithRetry.deliver_now { CustomersMailer.reset_password_instructions(record, token, opts) }
    end
  end
end
