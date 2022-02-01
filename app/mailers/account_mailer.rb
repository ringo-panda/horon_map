class AccountMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.Account_mailer.send_when_signup.subject
  #
  def send_when_signup(user)
    @name = user.name
    mail(
      from: "HoronMap事務局 <" + ENV['MAILER_ADDRESS'] + ">",
      to: user.name + "様 <" + user.email + ">",
      subject: '【HoronMap】ご登録いただきありがとうございます!'
    )
  end

  def send_when_account_update(user)
    @name = user.name
    mail(
      from: "HoronMap事務局 <" + ENV['MAILER_ADDRESS'] + ">",
      to: user.name + "様 <" + user.email + ">",
      subject: '【HoronMap】登録情報が変更されました。'
    )
  end

  def send_when_account_delete(user)
    @name = user.name
    mail(
      from: "HoronMap事務局 <" + ENV['MAILER_ADDRESS'] + ">",
      to: user.name + "様 <" + user.email + ">",
      subject: '【HoronMap】アカウントが削除されました。'
    )
  end
end
