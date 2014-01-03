class Goaler < ActionMailer::Base
  default from: "from@example.com"


  def send_mail_to_goaler(goaler,mentor)
  	@goaler = goaler
  	@mentor = mentor
  	mail(to: @goaler.email, subject: 'Welcome to pace')
  end
end
