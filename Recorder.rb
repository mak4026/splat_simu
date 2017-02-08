require './player.rb'

class Recorder < Player
  attr_reader :records
  def initialize(ps)
    super
    @records = []
  end

  def write_record(friends, rivals, result)
    present = {}
    present[:friends] = friends
    present[:rivals] = rivals
    present[:result] = result ? "win" : "lose"
    present[:udemae] = @udemae

    @records << present
  end
end

def recorder_include?(aTeam)
  aTeam.each { |player|
    if player.instance_of?(Recorder)
      return player
    end
  }
  false
end

def result_record(recorder, friend_team, rival_team, result)
  friend = friend_team.dup
  deleted = friend.delete(recorder)
  raise "recorder not found" if deleted.nil?
  recorder.write_record(Marshal.load(Marshal.dump(friend)), Marshal.load(Marshal.dump(rival_team)), result)
end
