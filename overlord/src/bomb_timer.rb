require "active_support/time"
require "thread"

class TimerError < RuntimeError; end

class BombTimer
  attr_reader :deadline, :started
  alias_method :started?, :started
  SECONDS_REMAINING = 30

  def initialize(remaining = SECONDS_REMAINING)
    @seconds_remaining = remaining.seconds
    @started = false
  end

  def start
    raise(TimerError, "cannot start the timer. it is already running") if started?
    @deadline = Time.now + @seconds_remaining
    @started = true
  end

  def stop
    raise(TimerError, "cannot stop the timer. it is not running") unless started?
    @seconds_remaining = (deadline - Time.now)
    @started = false
    @deadline = nil
  end

  def triggered?
    if !started?
      false
    else
      deadline < Time.now
    end
  end

  def seconds_remaining
    if started?
      (deadline - Time.now).floor
    else
      @seconds_remaining.floor
    end
  end

  def reset(remaining = SECONDS_REMAINING)
    @seconds_remaining = remaining.seconds
    @deadline = Time.now + @seconds_remaining
  end
end
