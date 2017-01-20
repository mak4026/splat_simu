require './player.rb'

def battle(alpha, blabo)
  if judge(alpha, blabo)
    alpha.each { |aPlayer|
      aPlayer.win
    }
    blabo.each { |aPlayer|
      aPlayer.lose
    }
  else
    alpha.each { |aPlayer|
      aPlayer.lose
    }
    blabo.each { |aPlayer|
      aPlayer.win
    }
  end
end

def judge(alpha, blabo)
  a_power = b_power = 0
  alpha.each { |aPlayer|
    a_power += aPlayer.player_skill
  }
  blabo.each { |aPlayer|
    b_power += aPlayer.player_skill
  }

  if(a_power >= b_power)
    true
  else
    false
  end
end

def play_one_game(players, dropouts, counter_stops)
  players.shuffle!
  teams = players.each_slice(4).to_a
  matching = teams.each_slice(2).to_a

  matching.each { |aRoom|
    if aRoom.length == 2 && aRoom[1].length == 4
      battle(aRoom[0], aRoom[1])
    end
  }

  temp_players = matching.flatten

  temp_players.each_with_index{ |aPlayer, i|
    if aPlayer.dropout?
      dropouts << aPlayer
      # temp_players.delete_at(i)
    end
    if aPlayer.counter_stop?
      counter_stops << aPlayer
      # temp_players.delete_at(i)
    end
  }

  players = temp_players

  return players, dropouts, counter_stops
end

def play_games(players, dropouts, counter_stops, repeat)
  repeat.times{
    players, dropouts, counter_stops = play_one_game(players, dropouts, counter_stops)
  }
  return players, dropouts, counter_stops
end
