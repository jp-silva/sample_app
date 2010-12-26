class ParticipantesController < ApplicationController
  def index
  end

  
  def create
    @participante = current_user.concursos.build(params[:concurso])
    if @participante.save
      flash[:success] = "Está !"
      redirect_to concursos_path
    else
      @title = "Novo concurso"
      render 'new'
    end
  end

end
