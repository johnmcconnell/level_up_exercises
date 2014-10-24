require_relative "wire"

class WireBox
  attr_reader :wires, :triggered
  alias_method :triggered?, :triggered
  def initialize(params)
    @wires = parse_wires(params)
    @safe_wire = @wires.find { |wire| wire.safe? }
    raise("there is no wire which matches the safe color") if @safe_wire.nil?
    @triggered = false
  end

  def snip(color)
    wire = @wires.find { |w| w.color == color }
    raise("there is no wire of color '#{color}'") if wire.nil?
    wire.snip
    @triggered = true unless wire == @safe_wire
  end

  def deactivated?
    @safe_wire.snipped?
  end

  private

  def parse_wires(params)
    params[:wire_colors].map do |color|
      wire =  Wire.new(color)
      wire = Wire.new(color, true) if color == params[:safe_color]
      wire
    end
  end
end
