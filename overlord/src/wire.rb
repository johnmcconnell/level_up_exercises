
class Wire
  attr_reader :color, :snipped
  alias_method :snipped?, :snipped
  def initialize(color)
    @color = color
    @snipped = false
  end

  def snip
    @snipped = true
  end
end
