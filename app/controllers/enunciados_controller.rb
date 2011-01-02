class EnunciadosController < ApplicationController
  before_filter :admin_user,   :only => [:edit, :update, :new, :destroy, :create]
  
  def show
	@title = "Enunciado"
	@enunciado = Enunciado.find(params[:id])
	@function = Function.find(@enunciado.funcao_id)
	@language = Language.find(@enunciado.linguagem_id)	
	
	@tentativa = Tentativa.new
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
	  createFolder
    else
      @title = "Novo enunciado"
      render 'new'
    end
  end
  
	def destroy
	  @enunciado = Enunciado.find(params[:id])
	  con = @enunciado.concurso_id
	  @concurso = Concurso.find(@enunciado.concurso_id)
	  deleteFolder
      @enunciado.destroy
      redirect_back_or concurso_path(Concurso.find(con))
	end

  private 
  
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
	
	
	def createFolder
		path = File.join(Rails.root, "data/concursos",@concurso.id.to_s,"enunciados")
		if !File.exists?(path)
			Dir.mkdir(path)
		end
		
		path = File.join(Rails.root, "data/concursos",@concurso.id.to_s,"enunciados",@enunciado.id.to_s)
		
		if !File.exists?(path)
			Dir.mkdir(path)
		end
	end
	
	def deleteFolder
		path = File.join(Rails.root, "data/concursos",@concurso.id.to_s,"enunciados",@enunciado.id.to_s)
		if File.exists?(path)
			`rm -rf #{path}`
		end
	end
    
end
