ActionMailer::Base.smtp_settings = {
  address: "smtp-relay.sendinblue.com",
  port: 587,
  domain: "https://secret-beach-91446.herokuapp.com",
  user_name: ENV["SENDINBLUE_USERNAME"],
  password: ENV["SENDINBLUE_PASSWORD"]
}
