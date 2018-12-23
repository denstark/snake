require 'curses'
require 'logger'

Curses.init_screen
Curses.curs_set 0 # Invisible Cursor
Curses.noecho
Curses.raw
Curses.ESCDELAY = 0

$logger = Logger.new('/tmp/snake.log')

class SnakeWindow
  WINDOW_WIDTH = 100
  WINDOW_HEIGHT = 50
  attr_reader :mainWindow
  attr_accessor :curX, :curY

  def initialize
    @mainWindow = Curses::Window.new(WINDOW_HEIGHT, WINDOW_WIDTH, (Curses.lines - WINDOW_HEIGHT) / 2, (Curses.cols - WINDOW_WIDTH) / 2 )
    @mainWindow.box("|", "-")
    @mainWindow.refresh
    @mainWindow.keypad true
    @mainWindow.nodelay = true
    @curX = 0
    @curY = 0
  end

  def setPos(y, x)
    maxY = mainWindow.maxy - 2
    maxX = mainWindow.maxx - 2
    if y > maxY
      y = maxY
    end
    if x > maxX
      x = maxX
    end
    if y < 1
      y = 1
    end
    if x < 1
      x = 1
    end

    mainWindow.setpos(y, x)
    self.curY = y
    self.curX = x
    $logger.info "curY = #{curY}, curX = #{curX}"
  end

  def clearScreen
    mainWindow.clear
  end

  def maxX
    return self.mainWindow.maxx
  end

  def maxY
    return self.mainWindow.maxy
  end

  def printChar(char, y = self.curY, x = self.curX)
    setPos(y, x)
    mainWindow.addstr(char)
    mainWindow.refresh
  end
end

class MenuWindow
  WINDOW_HEIGHT = 10
  WINDOW_WIDTH = 30

  attr_reader :mainWindow

  def initialize
    @mainWindow = Curses::Window.new(WINDOW_HEIGHT, WINDOW_WIDTH, (Curses.lines - WINDOW_HEIGHT) / 2, (Curses.cols - WINDOW_WIDTH) / 2 )
    @mainWindow.box("|", "-")
    @mainWindow.refresh
    @mainWindow.keypad true
  end

  def doMenu
    mainWindow.setpos(2, 6)
    mainWindow.addstr("Q: Quit")
    mainWindow.setpos(3, 6)
    mainWindow.addstr("R: Restart Game")
    mainWindow.setpos(4, 6)
    mainWindow.addstr("H: High Score")
    mainWindow.setpos(8, 6)
    mainWindow.addstr("ESC: Resume Game")
    mainWindow.getch
  end
end

class SnakeSegment
  attr_reader :y, :x
  def initialize(y, x)
    @y = y
    @x = x
  end
end

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
      newHeadX = self.headX + 2
      if newHeadX > window.maxX
        newHeadX = window.maxX
      end
      self.headX = newHeadX
    when Snake::LEFT
      newHeadX = self.headX - 2
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

begin
  win = SnakeWindow.new
  $logger.info "------- NEW GAME -------"
  snake = Snake.new
  running = true
  direction = Snake::RIGHT
  while (running) do
    char = win.mainWindow.getch
    $logger.info "char: #{char}"
    case char
    when Curses::KEY_LEFT, "h"
      direction = Snake::LEFT
      $logger.info "Received left"
    when Curses::KEY_RIGHT, "l"
      direction = Snake::RIGHT
      $logger.info "Received right"
    when Curses::KEY_DOWN, "j"
      direction = Snake::DOWN
      $logger.info "Received down"
    when Curses::KEY_UP, "k"
      direction = Snake::UP
      $logger.info "Received up"
    when 27
      win.mainWindow.nodelay = false
      menu = MenuWindow.new
      menu.doMenu
      win.mainWindow.nodelay = true
    when "Q"
      break
    end

    $logger.info "Direction is #{direction}"
    snake.newPos(win, direction)
    win.mainWindow.clear
    win.mainWindow.box("|", "-")
    win.printChar(snake.symbol, snake.headY, snake.headX)
    win.mainWindow.refresh
    sleep 0.07
  end
ensure
  Curses.close_screen
end