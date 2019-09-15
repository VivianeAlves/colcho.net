class UsersController < ApplicationController
  before_action :require_no_authentication, only: [:new, :create]
  
  def new
    @user = User.new
  end

  def show
    # só mostra o registro se a id do usuario logado é igual ao que ele quer acessar!
    # ou seja o usuário não consegue visualizar o perfil alheio
    if (!user_signed_in?) || (current_user != find_user_id)
      redirect_to root_path, :notice => "Error 404 - Página não encontrada"
    end
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params.require(:user).permit(:full_name, :email, :password, :password_confirmation, :bio, :location))
    if @user.save
      SignupMailer.confirm_email(@user).deliver
      redirect_to @user,
                  :notice => "Cadastro Criado com Sucesso!"
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id]),
        if @user.update_attributes(params[:user])
          redirect_to @user, :notice => "Cadastro atualizado com sucesso!"
        else
          render :update
        end
  end

  private

  def can_change
    unless user_signed_in? && current_user == find_user_id
      redirect_to root_path
    end
  end

  def find_user_id
    @user ||= User.find(params[:id])
  end

end