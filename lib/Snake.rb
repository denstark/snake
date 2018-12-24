class Snake
  RIGHT = 'R'
  LEFT = 'L'
  UP = 'U'
  DOWN = 'D'

  attr_reader :symbol
  attr_accessor :direction, :headX, :headY, :body

  def initialize
    @symbol = '#'
    @headX = 15
    @headY = 15
    @body = [SnakeSegment.new(@headY, @headX)]
    @direction = nil
  end

  def length
    return self.body.length
  end

  def addSegment(window)
    lastSegX = @body.last.x
    lastSegY = @body.last.y
    newHeadX = lastSegX
    newHeadY = lastSegY

    case @direction
    when Snake::RIGHT
      newHeadX = lastSegX + 1 # Create Constant
      if newHeadX > window.maxX
        newHeadX = window.maxX
      end
    when Snake::LEFT
      newHeadX = lastSegX - 1 # Create Constant
      if newHeadX < 1
        newHeadX = 1
      end
    when Snake::UP
      newHeadY = lastSegY - 1
      if newHeadY < 1
        newHeadY = 1
      end
    when Snake::DOWN
      newHeadY = lastSegY + 1
      if newHeadY > window.maxY
        newHeadY = window.maxY
      end
    end
    @body.push(SnakeSegment.new(newHeadY, newHeadX))
  end

  def next(window)
    logger = SLogger.instance.logger
    lastSegX = @body.last.x
    lastSegY = @body.last.y
    newHeadX = lastSegX
    newHeadY = lastSegY
    logger.info "Last Seg Y: #{lastSegY} Last Seg X: #{lastSegX}"
    @body.shift
    
    case @direction
    when Snake::RIGHT
      newHeadX = lastSegX + 1 # Create Constant
      if newHeadX > window.maxX
        newHeadX = window.maxX
      end
    when Snake::LEFT
      newHeadX = lastSegX - 1 # Create Constant
      if newHeadX < 1
        newHeadX = 1
      end
    when Snake::UP
      newHeadY = lastSegY - 1
      if newHeadY < 1
        newHeadY = 1
      end
    when Snake::DOWN
      newHeadY = lastSegY + 1
      if newHeadY > window.maxY
        newHeadY = window.maxY
      end
    end
    logger.info "--- POST PROCESSING ---"
    logger.info "New Head Y: #{newHeadY} New Head X: #{newHeadX}"
    @body.push(SnakeSegment.new(newHeadY, newHeadX))
  end

  def randDirection
    directions = [Snake::RIGHT, Snake::LEFT, Snake::UP, Snake::DOWN]
    return directions.sample
  end

  def newPos(window, direction)
    case direction
    when Snake::RIGHT
      newHeadX = self.headX + 1 # Create Constant
      if newHeadX > window.maxX
        newHeadX = window.maxX
      end
      self.headX = newHeadX
    when Snake::LEFT
      newHeadX = self.headX - 1 # Create Constant
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