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
  end

  def destroy
      Concurso.find(params[:id]).destroy
      redirect_back_or concursos_path
  end

  
  
  private 
  
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
    
    def participante(concurso)
      aux = Participante.where(:user_id=>current_user.id , :concurso_id=>concurso.id).first
    end


end
