class HybridCross

  attr_accessor :Parent1  
  attr_accessor :Parent2
  attr_accessor :F2_Wild
  attr_accessor :F2_P1
  attr_accessor :F2_P2
  attr_accessor :F2_P1P2
  attr_accessor :Sum
  @@all_crosses = []
  @@linked_genes = []
  
  def initialize (params = {})

    @Parent1 = params.fetch(:Parent1, nil)
    @Parent2 = params.fetch(:Parent2, nil)
    @F2_Wild = params.fetch(:F2_Wild, nil).to_f
    @F2_P1 = params.fetch(:F2_P1, nil).to_f
    @F2_P2 = params.fetch(:F2_P2, nil).to_f
    @F2_P1P2 = params.fetch(:F2_P1P2, nil).to_f
    @Sum = 0.0
    @@all_crosses << self

    
  end


  def HybridCross.all_crosses
    return @@all_crosses
  end

  def HybridCross.all_linked_genes
    return @@linked_genes
  end


  def genetically_linked
    
    @Sum = @F2_Wild + @F2_P1  + @F2_P2  + @F2_P1P2
    ex_W = @Sum*9/16
    ex_P1 = @Sum*3/16
    ex_P2 = @Sum*3/16
    ex_P1P2 = @Sum*1/16
  
    chi_sq = (@F2_Wild - ex_W)**2/ex_W + 
             (@F2_P1 - ex_P1)**2/ex_P1 + 
             (@F2_P2 - ex_P2)**2/ex_P2 + 
             (@F2_P1P2 - ex_P1P2)**2/ex_P1P2
    #http://labrad.fisica.edu.uy/docs/tabla_chi_cuadrado.pdf
    #3 Grados de libertad
    #0.05 Probabilidad de encontrar un valor mayor o igual que el chi cuadrado tabulado.

    if chi_sq > 7.8147
      @@linked_genes << [@Parent1, @Parent2]
      return @Parent1, @Parent2, chi_sq
    end
    
  end
end

