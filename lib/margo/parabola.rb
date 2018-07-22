class Margo::Parabola
  attr_accessor :equation
  attr_accessor :point_array
  attr_accessor :smallest_x
  attr_accessor :largest_x

  def initialize(pt1, pt2, pt3)
    @point_array = [pt1, pt2, pt3]
    @smallest_x, @largest_x = Margo.find_delta_x_of_3(pt1, pt2, pt3)
    @orig_vals = [[0, 0, 0], [0, 0, 0], [0, 0, 0]]
    count = 0
    point_array.each do |point|
      self.class.store_initial_equation(point.get_x, point.get_y, @orig_vals, count)
      count += 1
    end
    @equation = [0, 0, 0]
    @equation = self.class.calculate_slope(@orig_vals, @equation)
  end

  def self.store_initial_equation(x, y, orig_vals, count)
    x2 = x**2
    # A zero value in the gcd algorithm breaks it, but it needs that zero
    # comparator to work. So this does if either x or y is 0, factor equals 1.
    factor = x > 0 && y > 0 ? gcd(x.abs, y.abs) : 1
    if factor > 1
      x2 /= factor
      x /= factor
      y /= factor
    end
    orig_vals[count] = [y, x2, x]
  end

  def self.calculate_slope(orig_vals, equation)
    vals_after_c = [[0, 0, 0], [0, 0, 0]]
    vals_after_c[0] = combine_to_remove_c(orig_vals[0], orig_vals[1])
    vals_after_c[1] = combine_to_remove_c(orig_vals[1], orig_vals[2])
    vals_after_b = combine_to_remove_b(vals_after_c[0], vals_after_c[1])
    equation[0] = vals_after_b[0] / vals_after_b[1]
    equation[1] = get_b(vals_after_c, equation)
    equation[2] = get_c(orig_vals, equation)
    equation
  end

  def self.combine_to_remove_c(full_equation_1, full_equation_2)
    y = full_equation_1[0] + (full_equation_2[0] * -1)
    x2 = full_equation_1[1] + (full_equation_2[1] * -1)
    x = full_equation_1[2] + (full_equation_2[2] * -1)
    # puts [y, x2, x]
    [y, x2, x]
  end

  def self.combine_to_remove_b(equation_less_c_1, equation_less_c_2)
    b_coef_1 = equation_less_c_1[2].abs
    b_coef_2 = equation_less_c_2[2].abs
    bigger_b = (b_coef_1 > b_coef_2 ? equation_less_c_1 : equation_less_c_2)
    little_b = (b_coef_1 <= b_coef_2 ? equation_less_c_1 : equation_less_c_2)
    mul_amount = (little_b[2] == 0 ? mul_amount = 1 : mul_amount = (bigger_b[2] * -1.0) / little_b[2])
    y = bigger_b[0] + (little_b[0] * mul_amount)
    x2 = bigger_b[1] + (little_b[1] * mul_amount)
    x = bigger_b[2] + (little_b[2] * mul_amount)
    [y, x2, x]
  end

  def self.get_b(vals_after_c, equation)
    b1 = ((vals_after_c[0][0] - (equation[0] * vals_after_c[0][1])) / vals_after_c[0][2])
    b2 = ((vals_after_c[1][0] - (equation[0] * vals_after_c[1][1])) / vals_after_c[1][2])
    if b1 == b2
      b1
    else
      puts "Your B calculations don't match."
    end
  end

  def self.get_c(orig_vals, equation)
    c1 = (((orig_vals[0][1] * equation[0]) + (orig_vals[0][2] * equation[1]) - (orig_vals[0][0])) * -1)
    c2 = (((orig_vals[1][1] * equation[0]) + (orig_vals[1][2] * equation[1]) - (orig_vals[1][0])) * -1)
    c3 = (((orig_vals[2][1] * equation[0]) + (orig_vals[2][2] * equation[1]) - (orig_vals[2][0])) * -1)

    if c1 == c2 and c2 == c3
      c1
    else
      puts "Your C calculations don't match."
    end
  end

  def self.gcd(val_1, val_2)
    # Stein algorithm coded by https://gist.github.com/peterc/1582783
    return val_2 if val_1.zero?
    return val_1 if val_2.zero?
    return val_1 if val_1 == val_2

    if val_1.even? && val_2.even?
      gcd(val_1 >> 1, val_2 >> 1) << 1
    elsif val_1.even?
      gcd(val_1 >> 1, val_2)
    elsif val_2.even?
      gcd(val_1, val_2 >> 1)
    elsif val_1 > val_2
      gcd((val_1 - val_2) >> 1, val_2)
    else
      gcd(val_1, (val_2 - val_1) >> 1)
    end
  end

  def collision(ball_x, ball_y)
    @answer = false
    if ball_x <= largest_x && ball_x >= smallest_x
      @answer = true if ball_y == (equation[0] * (ball_x**2)) + (equation[1] * ball_x) + equation[2]
    end
    @answer
  end

  def react; end
end