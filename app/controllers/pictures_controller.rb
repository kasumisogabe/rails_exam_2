class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]

  def index
    @pictures = Picture.all
  end

  def new
    @picture = Picture.new
  end

  def create
    @picture = current_user.pictures.build(picture_params)
    return render :new if params[:back]
    if @picture.save
      redirect_to pictures_path, notice: '画像を投稿しました'
      ContactMailer.contact_picture(@picture).deliver
    else
      render :new
    end
  end

  def show
    @favorite = current_user.favorites.find_by(picture_id: @picture.id)
  end

  def edit
    if @user == current_user
      render "edit"
    else
      redirect_to pictures_path
    end
  end

  def update
    if @picture.update(picture_params)
      redirect_to pictures_path, notice: '投稿を編集しました'
    else
      render :edit
    end
  end

  def destroy
    if @user == current_user
      render "destroy"
    else
      redirect_to pictures_path
    end
    @picture.destroy
    redirect_to picturess_path, notice:"ブログを削除しました！"
  end

  def confirm
    @picture = Picture.new(picture_params)
    @picture = current_user.pictures.build(picture_params)
    render :new if @picture.invalid?
  end

  private

  def picture_params
    params.require(:picture).permit(:title, :content, :image, :image_cache)
  end

  def set_picture
    @picture = Picture.find(params[:id])
  end
end
