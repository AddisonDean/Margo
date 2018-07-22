class Margo
  def self.find_delta_x_of_2(pt1, pt2)
    @big_x = @little_x = pt1.get_x
    if pt2.get_x >= @big_x
      @big_x = pt2.get_x
    else
      @little_x = pt2.get_x
    end
    [@little_x, @big_x]
  end

  def self.find_delta_x_of_3(pt1, pt2, pt3)
    @big_x = @little_x = pt1.get_x
    if pt2.get_x >= @big_x
      @big_x = pt2.get_x
    else
      @little_x = pt2.get_x
    end
    if pt3.get_x >= @big_x
      @big_x = pt3.get_x
    elsif pt3.get_x < @little_x
      @little_x = pt3.get_x
    end
    [@little_x, @big_x]
  end

end

require 'margo/point'
require 'margo/line'
require 'margo/parabola'
require 'margo/curve'
