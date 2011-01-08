class ConcursosController < ApplicationController
   before_filter :admin_user,   :only => [:edit, :update, :new, :destroy, :create]
   before_filter :authenticate
  
  def index
    @title = "Todos os concursos"
    @concursos = Concurso.paginate(:page => params[:page])
  end
  
  def new
    @title = "Novo concurso"
    if signed_in?
      if current_user.admin?
        @concurso = Concurso.new 
      end
    end  
  end

  def create
    @concurso = current_user.concursos.build(params[:concurso])
    if @concurso.save
      flash[:success] = "Concurso criado com sucesso!"
      redirect_to concursos_path
    else
      @title = "Novo concurso"
      render 'new'
    end
	
	createFolder
  end
  
  def show
    @concurso = Concurso.find(params[:id])
    @title = @concurso.tit

    @participante = Participante.new 
  
    if(current_user.admin? || (( participante(@concurso) && tRestante(@concurso)>0 ) ) )
        @enunciados = @concurso.enunciados
    else
        @enunciados = nil
    end
    
  end

  def destroy
	  @concurso = Concurso.find(params[:id])
	  deleteFolder
      @concurso.destroy
      redirect_back_or concursos_path
  end

  
  
  private 
  
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
    
    #verifica se é participante, se for retorna-o
    def participante(concurso)
      aux = Participante.where(:user_id=>current_user.id , :concurso_id=>concurso.id).first
    end  

    #calcula hora do fim do concurso para o utilizador actual
    def terminaC(concurso)
      advanceMin = concurso.dur.hour*60 + concurso.dur.min
      return participante(concurso).dataRegisto.advance(:minutes=> advanceMin)
    end

    #calcula o tempo que resta ao utilizador logado para continuar a participar
    def tRestante(concurso)
      return ((terminaC(concurso) - DateTime.now) / 60)
    end

				
		def createFolder
			path = File.join(Rails.root, "data/")
			if !File.exists?(path)
				Dir.mkdir(path)
			end
		
			path = File.join(Rails.root, "data/concursos")
			if !File.exists?(path)
				Dir.mkdir(path)
			end
			
			path = File.join(Rails.root, "data/concursos",@concurso.id.to_s)
			if !File.exists?(path)
				Dir.mkdir(path)
			end
		end
	
		def deleteFolder
			path = File.join(Rails.root, "data/concursos",@concurso.id.to_s)
			if File.exists?(path)
				`rm -rf #{path}`
			end
		end
end
