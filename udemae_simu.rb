require 'random_bell'
require 'optparse'
require 'csv'
require './player.rb'
require './game.rb'


def csv_export(players)
  csv_name = "splasimu"+Time.now.strftime("%F_%H%M%S")+".csv"
  csv_header = ["udemae", "player_skill", "game_count", "counter_stop", "dropout"]
  csv_data = CSV.generate("", :headers => csv_header, :write_headers => true) do |csv|
    players.each{ |aPlayer|
      csv << [
        aPlayer.udemae,
        aPlayer.player_skill,
        aPlayer.game_count,
        aPlayer.counter_stop?,
        aPlayer.dropout?
      ]
    }
  end

  File.open(csv_name, "w") {|file|
    file.write(csv_data)
  }

end

$params = ARGV.getopts('n:')

N = $params["n"].to_i
GAME_REPEAT_COUNT = 1000

bell = RandomBell.new(mu: 50, sigma: 20, range: 0..100)
puts bell.to_histogram

players = []
dropouts = []
counter_stops = []

N.times {
  players.push(Player.new(bell.rand))
}

players, dropouts, counter_stops = play_games(players, dropouts, counter_stops, GAME_REPEAT_COUNT)

csv_export(players)
