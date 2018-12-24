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
    @logger = SLogger.instance.logger
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
