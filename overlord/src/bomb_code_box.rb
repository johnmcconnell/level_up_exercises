class CodeBoxError < RuntimeError; end

require_relative "bomb_code"

class BombCodeBox
  DEFAULT_CODE = "1234"
  attr_reader :active
  alias_method :active?, :active

  def initialize
    @active = false
    @guess_count = 0
  end

  def activate(code = DEFAULT_CODE)
    raise(CodeBoxError, "cannot activate, an active box") if active? || triggered?
    @code = BombCode.new(code)
    @active = true
  end

  def deactivate(code)
    raise(CodeBoxError, "cannot deactive, an inactive box") if !active? || triggered?
    new_code = BombCode.new(code)
    (new_code == @code) ? reset : record_attempt
  end

  def triggered?
    @guess_count >= 2
  end

  private

  def record_attempt
    @guess_count += 1
  end

  def reset
    @active = false
    @guess_count = 0
  end
end
