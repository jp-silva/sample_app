module EnunciadoHelper
  
  def arrayLing
    array = Array.new
    Linguagem.all.each do |l|
      array << [l.ling,l.id]
    end
    return array
  end

  def arrayFunc
    array = Array.new
    Funcao.all.each do |f|
      array << [f.func,f.id]
    end
    return array
  end

  def nums
    array = Array.new
    (0..100).to_a.each do |n|
      array << [n,n]
    end
  end
  
end
