class TentativasController < ApplicationController
  def index
  end

  def create
	@enunciado = Enunciado.find(params[:enunciado_id])
	params[:tentativa][:user_id] = current_user.id
	auxPath
	
	
	@tentativa = @enunciado.tentativas.build(params[:tentativa])
    if @tentativa.save
      flash[:success] = "Tentativa submetida com sucesso!"
      redirect_to @tentativa
    else
      @title = "Enunciado"
      render @enunciado
    end

  end

  def destroy
  end

  def show
	@tentativa = Tentativa.find(params[:id])
  end
  
  
  
  private
	def auxPath
		#timestamp
		t = DateTime.now

		# cria o caminho físico do arquivo
		filename = t.to_s(:number) + "-" + params[:tentativa][:path].original_filename
		path = File.join(Rails.root, "public/images/concursos",@enunciado.concurso_id.to_s,"/enunciados",@enunciado.id.to_s,"user-"+current_user.id.to_s)
		#completa o path com o nome do ficheiro
		path = File.join(path,filename)

		#cria a pasta caso nao exista
		if !File.exists?(File.dirname(path))
			Dir.mkdir(File.dirname(path))
		end
		
		# escreve o arquivo no local designado
		File.open(path, "wb") do |f| 
			f.write(params[:tentativa][:path].read)
		end


	end
  
  
  
end
