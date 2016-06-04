class ZombieMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.zombie_mailer.decomp_change.subject
  #
  def decomp_change(zombie)
    @zombie = zombie
    @last_tweet = @zombie.tweets.last
    attachments['z.pdf']=File.read("#{Rails.root}/public/file_1_test.pdf")
    # In case @zombie has an attribute (column) called picture and has an image file in it, you can add it as an attachments in email:
    # attachments["my_photo.jpg"] = @zombie.picture
    # This will name the file "my_photo.jpg"
    # @greeting = "Hi"
    mail(to: "kfatiguso@gmail.com", subject: "Your decomp stage has changed")
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.zombie_mailer.lost_brain.subject
  #
  def lost_brain
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
