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