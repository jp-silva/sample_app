class EnunciadosController < ApplicationController
  before_filter :admin_user,   :only => [:edit, :update, :new, :destroy, :create]
  
  def show
	@title = "Enunciado"
	@enunciado = Enunciado.find(params[:id])
	@function = Function.find(@enunciado.funcao_id)
	@language = Language.find(@enunciado.linguagem_id)	
  end

  def new
    @title = "Novo enunciado"
    @enunciado = Enunciado.new
    @concurso_id = params[:concurso_id]
    @array = Array.new
  end

  def create
	params[:enunciado][:funcao_id] = params[:funcao_id]
	params[:enunciado][:linguagem_id] = params[:linguagem_id]
	params[:enunciado][:peso] = params[:peso]
	
    @concurso = Concurso.find(params[:concurso_id])
    @enunciado = @concurso.enunciados.build(params[:enunciado])
    if @enunciado.save
      flash[:success] = "Enunciado criado com sucesso!"
      redirect_to concurso_path(@concurso)
    else
      @title = "Novo enunciado"
      render 'new'
    end
  end
  
	def destroy
	  con = Enunciado.find(params[:id]).concurso_id 
      Enunciado.find(params[:id]).destroy
      redirect_back_or concurso_path(Concurso.find(con))
	end

  private 
  
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
    
end
