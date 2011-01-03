class TestesController < ApplicationController

  before_filter :admin_user,   :only => [:edit, :update, :new, :destroy, :create,:show]

  def index
    @teste = Teste.new
    @title = "Testes"
    if params[:enunciado_id]
      @enunciado = Enunciado.find(params[:enunciado_id])
      @testes = @enunciado.testes.paginate(:page => params[:page])
    end
  end
  
  def create
    if params[:enunciado_id]
      @enunciado = Enunciado.find(params[:enunciado_id])
      @teste = @enunciado.testes.build(params[:teste])
      if @teste.save
        flash[:success] = "Teste adicionado com sucesso!"
        redirect_to testes_path(:enunciado_id=>@enunciado.id)
      else
        @title = "Testes"
        render 'index'
      end
    else 
      redirect root_path
    end
  end
  
  def destroy
    @teste = Teste.find(params[:id])
    @enunciado = Enunciado.find(@teste.enunciado_id)
    @teste.destroy
    redirect_back_or testes_path(:enunciado_id=>@enunciado.id)
  end
  
  
  
  private 
  
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

end
