class EnunciadosController < ApplicationController
  before_filter :admin_user,   :only => [:edit, :update, :new, :destroy, :create]
  
  def show
  end

  def new
    @title = "Novo concurso"
    @enunciado = Enunciado.new
    @concurso_id = params[:concurso_id]
    @array = Array.new
  end

  #def create
   # @concurso = Concurso.find(params[:concurso_id])
  #  @enunciado = @concurso.enunciados.build(params[:enunciado])
  #  if @enunciado.save
  #    flash[:success] = "Enunciado criado com sucesso!"
  #    redirect_to concurso_path(@concurso)
  #  else
  #    @title = "Novo concurso"
   #   render 'new'
  #  end
  #end

  private 
  
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
    
end
