require 'curses'
require 'singleton'
class ScreenWindow
  include Singleton
  attr_reader :mainWindow

  def initialize
    @mainWindow = Curses::Window.new(Curses.lines, Curses.cols, 0, 0)
  end

  def print(str, y, x)
    @mainWindow.setpos(y, x)
    @mainWindow.addstr(str)
    @mainWindow.refresh
  end
end