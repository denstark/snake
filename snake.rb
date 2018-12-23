require 'curses'
require 'logger'

Curses.init_screen
Curses.curs_set 0 # Invisible Cursor

class SnakeWindow
  attr_reader :mainWindow, :logger
  attr_accessor :curX, :curY

  def initialize
    @mainWindow = Curses::Window.new(Curses.lines, Curses.cols, 0, 0)
    @mainWindow.box("|", "-")
    @mainWindow.refresh
    @mainWindow.keypad true
    @logger = Logger.new('/tmp/snake.log')
    # @mainWindow.nodelay = true
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
    logger.info "curY = #{curY}, curX = #{curX}"
  end

  def clearScreen
    mainWindow.clear
  end

  def printChar(char, y = self.curY, x = self.curX)
    setPos(y, x)
    mainWindow.addstr(char)
    mainWindow.refresh
  end
end

begin
  win = SnakeWindow.new
  win.logger.info "------- NEW GAME -------"
  win.setPos(1, 5)
  running = true
  while (running) do
    char = win.mainWindow.getch
    win.logger.info "char: #{char}"
    case char
    when Curses::KEY_LEFT, "h"
      win.curX = win.curX - 1
      win.logger.info "Received left"
    when Curses::KEY_RIGHT, "l"
      win.curX = win.curX + 1
      win.logger.info "Received right"
    when Curses::KEY_DOWN, "j"
      win.curY = win.curY + 1
      win.logger.info "Received down"
    when Curses::KEY_UP, "k"
      win.curY = win.curY - 1
      win.logger.info "Received up"
    when "Q"
      break
    end

    win.mainWindow.clear
    win.mainWindow.box("|", "-")
    win.printChar('#', win.curY, win.curX)
    win.mainWindow.refresh
    # logger.info "Char is: #{char}"
  end
ensure
  Curses.close_screen
end