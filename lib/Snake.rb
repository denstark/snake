class Snake
  RIGHT = 'R'
  LEFT = 'L'
  UP = 'U'
  DOWN = 'D'

  attr_reader :symbol
  attr_accessor :direction, :headX, :headY, :body

  def initialize
    @symbol = '#'
    @headX = 5
    @headY = 5
    @body = [SnakeSegment.new(@headY, @headX)]
    @direction = nil
  end

  def length
    return self.body.length
  end

  def addSegment
  end

  def newPos(window, direction)
    case direction
    when Snake::RIGHT
      newHeadX = self.headX + 2 # Create Constant
      if newHeadX > window.maxX
        newHeadX = window.maxX
      end
      self.headX = newHeadX
    when Snake::LEFT
      newHeadX = self.headX - 2 # Create Constant
      if newHeadX < 1
        newHeadX = 1
      end
      self.headX = newHeadX
    when Snake::UP
      newHeadY = self.headY - 1
      if newHeadY < 1
        newHeadY = 1
      end
      self.headY = newHeadY
    when Snake::DOWN
      newHeadY = self.headY + 1
      if newHeadY > window.maxY
        newHeadY = window.maxY
      end
      self.headY = newHeadY
    end
  end
end