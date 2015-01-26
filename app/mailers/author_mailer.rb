class AuthorMailer < ActionMailer::Base
  default from: "hungnhottest@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.author_mailer.notify.subject
  #
  def notify(book)
    @book = book
    mail to: @book.author.email, subject: "[Book Manager]_Notify"
  end

  def notify_multiple(proc_email)
    mail to: proc_email, subject: "[Book Manager]_Notify"
  end
end
