class SnakeWindow
  WINDOW_WIDTH = 34
  WINDOW_HEIGHT = 30
  attr_reader :mainWindow, :food, :top, :left, :right
  attr_accessor :curX, :curY

  def initialize
    @logger = SLogger.instance.logger
    @top = (Curses.lines - WINDOW_HEIGHT) / 2
    @left = (Curses.cols - WINDOW_WIDTH) / 2
    @right = @left + WINDOW_WIDTH
    @mainWindow = Curses::Window.new(WINDOW_HEIGHT, WINDOW_WIDTH, @top, @left)
    @mainWindow.box("|", "-")
    @mainWindow.refresh
    @mainWindow.keypad true
    @mainWindow.nodelay = true
    @curX = 0
    @curY = 0
    @food = Food.new
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
    @logger.info "curY = #{curY}, curX = #{curX}"
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
