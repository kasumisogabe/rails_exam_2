class ContactMailer < ApplicationMailer
  def contact_mail(picture)
    @picture = picture

    mail to: @picture.email, subject: "画像投稿完了メール"
  end
end
