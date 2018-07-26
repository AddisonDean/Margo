class Margo::Line
  attr_accessor :points
  attr_accessor :equation
  attr_accessor :smallest_x
  attr_accessor :largest_x
  attr_accessor :react_cmd

  def initialize(pt1, pt2)
    @points = [pt1, pt2]
    @smallest_x, @largest_x = Margo.find_delta_x_of_2(pt1, pt2)
    @equation = self.class.determine_equation(pt1, pt2)
  end

  def self.determine_equation(pt1, pt2)
    @m = find_m(pt1, pt2)
    @b = find_b(pt1, pt2, @m)
    # return m and b in array
    [@m, @b]
  end

  def self.find_m(pt1, pt2)
    (pt2.get_y - pt1.get_y * 1.0) / (pt2.get_x - pt1.get_x * 1.0)
  end

  def self.find_b(pt1, pt2, m)
    b1 = (pt1.get_y - (m * pt1.get_x))
    b2 = (pt2.get_y - (m * pt2.get_x))
    if b1 == b2
      b1
    else
      puts "Your B calculations don't match."
    end
  end

  def collision(ball_x, ball_y, margin = 0)
    exact_target = (equation[0] * ball_x) + equation[1]
    @answer = false
    if ball_x <= largest_x && ball_x >= smallest_x
      @answer = true if ball_y <= exact_target + margin && ball_y >= exact_target - margin
    end
    @answer
  end

  def set_react_cmd(text)
    @react_cmd = text
  end

  def react
    react_cmd
  end
end
