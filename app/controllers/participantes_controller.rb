class ParticipantesController < ApplicationController
  before_filter :authenticate, :only => [:create]
  
  
  def index
    @participantes = Concurso.find(params[:concurso_id]).participantes.paginate(:page => params[:page])
  end

  
  def create
    @concurso = Concurso.find(params[:participante][:concurso_id])
    @participante = @concurso.participantes.build(params[:participante])
    if params[:participante][:chave] == @concurso.chave
      if @participante.save
        flash[:success] = "Sucesso. Pode comecar a participar no concurso!"
        redirect_to concurso_path(@concurso)
      else
        render 'concursos/show'
      end
    else
      flash.now[:error] = "Chave incorrecta!"
      render 'concursos/show'
    end
  end

end
