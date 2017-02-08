require 'random_bell'
require 'optparse'
require './player.rb'
require './Recorder.rb'
require './game.rb'
require './util.rb'

$exec_time = Time.now

$params = ARGV.getopts('n:r:')

N = $params["n"].to_i
GAME_REPEAT_COUNT = 1000
$record_ps = $params["r"].nil? ? nil : $params["r"].to_i
unless $record_ps.nil?
  raise ArgumentError, "0 < (Recorder's player_skill) < 100" unless $record_ps > 0 && $record_ps < 100
end

make_log

bell = RandomBell.new(mu: 50, sigma: 20, range: 0..100)
puts bell.to_histogram

players = []
dropouts = []
counter_stops = []

N.times {
  players.push(Player.new(bell.rand))
}

if $record_ps
  players.pop
  record_player = Recorder.new($record_ps)
  players.push(record_player)
end

players, dropouts, counter_stops = play_games(players, dropouts, counter_stops, GAME_REPEAT_COUNT)

csv_players_export(players)

if $record_ps
  csv_records_export(record_player)
end
