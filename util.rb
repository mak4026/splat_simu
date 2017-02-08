require 'csv'
require './player.rb'
require './Recorder.rb'
require './game.rb'

def make_log
  file_name = "splasimu#{$exec_time.strftime("%F_%H%M%S")}.log"
  File.open(file_name, "w"){ |file|
    $params.each{ |key,value|
      file.puts("#{key} => #{value}")
    }
  }
end

def csv_filename(id = "")
  csv_name = "splasimu" + $exec_time.strftime("%F_%H%M%S")
  csv_name << "_" + id unless id.empty?
  csv_name << ".csv"
  csv_name
end

def csv_players_export(players, id = "")
  csv_name = csv_filename()

  csv_header = ["udemae", "player_skill", "game_count", "win_count", "counter_stop", "dropout"]
  csv_data = CSV.generate("", :headers => csv_header, :write_headers => true) do |csv|
    players.each{ |aPlayer|
      csv << [
        aPlayer.udemae,
        aPlayer.player_skill,
        aPlayer.game_count,
        aPlayer.win_count,
        aPlayer.counter_stop?,
        aPlayer.dropout?
      ]
    }
  end

  File.open(csv_name, "w") {|file|
    file.write(csv_data)
  }

end

def csv_records_export(recorder)
  csv_name = csv_filename("records")
  csv_header = [
    "udemae",
    "result",
    "my_ps",
    "friend1_ps",
    "friend2_ps",
    "friend3_ps",
    "rival1_ps",
    "rival2_ps",
    "rival3_ps",
    "rival4_ps",
    "reason"
  ]
  csv_data = CSV.generate("", :headers => csv_header, :write_headers => true) do |csv|
    recorder.records.each{ |record|
      row = []
      row << record[:udemae]
      row << record[:result]
      row << recorder.player_skill
      record[:friends].each { |player|
        row << player.player_skill
      }
      record[:rivals].each { |player|
        row << player.player_skill
      }
      row << record[:reason].to_s
      csv << row
    }
  end

  File.open(csv_name, "w") {|file|
    file.write(csv_data)
  }

end
