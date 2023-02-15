class ContactMailer < ApplicationMailer
  def contact_mail(picture)
    @picture = picture

    mail to: ksm17sgb@gmail.com, subject: "画像投稿完了メール"
  end
end
