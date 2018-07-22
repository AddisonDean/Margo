# Maybe you should make a curve a type of line?
class Margo::Curve
  attr_accessor :curve_coords
  attr_accessor :smallest_x
  attr_accessor :largest_x

  def initialize(pt1, pt2, pt3)
    @smallest_x, @largest_x = Margo.find_delta_x_of_3(pt1, pt2, pt3)
    delta_x = @largest_x - @smallest_x
    @curve_coords = self.class.populate_array(pt1, pt2, pt3, delta_x)
  end

  def self.find_closest_x(ball_x, coordinates)
    count = 0
    closest_x_difference = (coordinates[0][0] - ball_x).abs
    matching_x_coord = []
    coordinates.each do |set|
      if (set[0] - ball_x).abs < closest_x_difference
        closest_x_difference = (set[0] - ball_x).abs
        matching_x_coord = []
        matching_x_coord.push(count)
      elsif (set[0] - ball_x).abs == closest_x_difference
        matching_x_coord.push(count)
      end
      count += 1
    end
    # This is sad. You should find an amount of tolerance that will change
    # with the scale of the curve robustly, not hardcode 5 like a dumbass.
    #puts closest_x_difference
    matching_x_coord = [] if closest_x_difference >= 5
    matching_x_coord
  end

  def self.populate_array(pt1, pt2, pt3, delta_x)
    curve_coords = []
    t = 0.00
    pos = 0
    while t < 0.99 + (1.00 / delta_x)
      curve_coords[pos] = calculate_values(pt1, pt2, pt3, t)
      t += (1.00 / delta_x)
      pos += 1
    end
    curve_coords
  end

  def self.calculate_values(pt1, pt2, pt3, t)
    table_x = (((1 - t)**2) * pt1.get_x) + (((-2 * (t**2)) + (2 * t)) * pt2.get_x) + ((t**2) * pt3.get_x)
    table_y = (((1 - t)**2) * pt1.get_y) + (((-2 * (t**2)) + (2 * t)) * pt2.get_y) + ((t**2) * pt3.get_y)
    [table_x.round(2), table_y.round(2)]
  end

  def collision(ball_x, ball_y)
    @answer = false
    if ball_x <= largest_x && ball_x >= smallest_x
      xvals = self.class.find_closest_x(ball_x, curve_coords)
      @answer = false if xvals.count.zero?
      xvals.each do |x|
        @answer = true if curve_coords[x][1] == ball_y
      end
    end
    @answer
  end

  def react; end
end