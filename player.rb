class Player
  attr_reader :udemae, :game_count, :player_skill
  def initialize(ps)
    @player_skill = ps
    @udemae = 50
    @game_count = 0
    @counter_stop = false
    @dropout = false
  end

  def win
    play
    @udemae += winner_udemae_change
    if @udemae > 99
      @udemae = 99
      @counter_stop = true
    end
  end

  def lose
    play
    @udemae -= loser_udemae_change
    if @udemae < 0
      dropout
    end
  end

  def counter_stop?
    @counter_stop
  end

  def dropout?
    @dropout
  end

  private

  def play
    @game_count += 1
  end

  def winner_udemae_change
    if @udemae >= 80
      2
    elsif @udemae >= 40
      3
    else
      4
    end
  end

  def loser_udemae_change
    if @udemae >= 40
      5
    else
      4
    end
  end

  def dropout
    @udemae = 0
    @dropout = true
  end

end
