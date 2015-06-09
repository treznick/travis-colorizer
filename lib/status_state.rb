class StatusState
  def initialize(filename)
    @filename = filename
  end

  def status
    lines = File.open(@filename, "r").readlines {|f| }
    case lines.count
    when 0
      :no_state
    when 1
      state_filter(lines.first.chomp.to_sym)
    else
      raise BadStateFileError, "too many lines in the state file"
    end
  end

  def status=(state)
    File.open(@filename, "w") do |file|
      file << state.to_s
    end
  end

  private

  def state_filter(state)
    if %i(red green yellow).include?(state)
      state
    else
      raise BadStateFileError, "#{state} is a bad state"
    end
  end
end

class BadStateFileError < StandardError; end
