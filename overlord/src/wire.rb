
class Wire
  attr_reader :color, :snipped, :safe
  alias_method :snipped?, :snipped
  alias_method :safe?, :safe
  def initialize(color, safe = false)
    @color = color
    @snipped = false
    @safe = safe
  end

  def snip
    @snipped = true
  end
end
