class UserMailer < ActionMailer::Base
  default from: "hi@rottenmangoes.ca"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.delete_notification.subject
  #
  def delete_notification(user)
    @user = user

    mail to: user.email, subject: "Your account has been canceled!"
  end
end
