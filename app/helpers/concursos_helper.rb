module ConcursosHelper
  
  def participante(concurso)
    aux = Participante.where(:user_id=>current_user.id , :concurso_id=>concurso.id).first
  end  
  
  def concursoActivo(concurso)
    (concurso.inicio<=DateTime.now && concurso.fim>=DateTime.now) ? true : false
  end
  
  def tAux(concurso)
    participante(concurso).dataRegisto += concurso.dur.hour
    return participante(concurso).dataRegisto.advance(:minutes=>concurso.dur.min)
 #   participante(concurso).dataRegisto -=  DateTime.now
#    return participante(concurso).dataRegisto
  end
  def tRestante(concurso)
    return ((tAux(concurso) - DateTime.now) / 60).to_int
  end
  
  #def tRestante(concurso)
   #   tAux2(concurso)>0 ? tAux2(concurso).to_int : nil
  #end
  

end
