class ConcursosController < ApplicationController
   before_filter :admin_user,   :only => [:edit, :update, :new, :destroy, :create]
  
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
    if signed_in?
      d = participante(@concurso) 
      if d
        @participante = d
      else
        @participante = Participante.new 
      end
    end
    
    if(participante(@concurso))
      if( ( tRestante(@concurso)>0 && participante(@concurso) )    || current_user.admin?) 
        @enunciados = @concurso.enunciados
      else
        @enunciados = nil
      end
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
    
    def participante(concurso)
      return aux = Participante.where(:user_id=>current_user.id , :concurso_id=>@concurso.id).first
    end
    
    def tAux(concurso)
      participante(concurso).dataRegisto += concurso.dur.hour
      return participante(concurso).dataRegisto.advance(:minutes=>concurso.dur.min)
    end
    
    def tRestante(concurso)
      return ((tAux(concurso) - DateTime.now) / 60).to_int
    end
    

	private
				
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
				flash[:success] = "MUITA SOPA!"
				`rm -rf #{path}`
			end
		end
end
