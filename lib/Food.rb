class Food
  attr_reader :x, :y, :symbol
  def initialize
    @x = nil
    @y = nil
    @symbol = 'o'
    self.newFood
  end

  def newFood
    @x = rand(2..SnakeWindow::WINDOW_WIDTH - 1)
    @y = rand(2..SnakeWindow::WINDOW_HEIGHT - 1)
  end
end