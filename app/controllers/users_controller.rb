class UsersController < ApplicationController
  def home
  end

  def index
    @users = User.where(deleted: false)
    respond_to do |format|
      format.html
      format.xlsx do
        timestamp = Time.current.strftime("%d-%m-%Y_%H-%M-%S")
        response.headers['Content-Disposition'] =
          "attachment; filename=usuarios_#{timestamp}.xlsx"
      end
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: "Usuario creado correctamente"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path, notice: "Usuario editado correctamente"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    # Eliminamos aplicando soft delete
    @user = User.find(params[:id])
    if @user.update(deleted: true)
      redirect_to users_path, notice: "Usuario eliminado correctamente"
    else
      redirect_to users_path, alert: "No se pudo eliminar el usuario"
    end
  end


  private
    def user_params
      params.require(:user).permit(:name, :lastname, :email, :age)
    end
end
