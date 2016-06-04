# Preview all emails at http://localhost:3000/rails/mailers/zombie_mailer
class ZombieMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/zombie_mailer/decomp_change
  def decomp_change
    ZombieMailer.decomp_change
  end

  # Preview this email at http://localhost:3000/rails/mailers/zombie_mailer/lost_brain
  def lost_brain
    ZombieMailer.lost_brain
  end

end
