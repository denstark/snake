require 'curses'
require 'require_all'
require_all 'lib/*.rb'
Curses.init_screen
Curses.curs_set 0 # Invisible Cursor
Curses.noecho
Curses.raw
Curses.ESCDELAY = 0
begin
  logger = SLogger.instance.logger
  win = SnakeWindow.new
  logger.info "------- NEW GAME -------"
  snake = Snake.new
  running = true
  direction = Snake::RIGHT
  while (running) do
    char = win.mainWindow.getch
    logger.info "char: #{char}"
    case char
    when Curses::KEY_LEFT, "h"
      direction = Snake::LEFT
      logger.info "Received left"
    when Curses::KEY_RIGHT, "l"
      direction = Snake::RIGHT
      logger.info "Received right"
    when Curses::KEY_DOWN, "j"
      direction = Snake::DOWN
      logger.info "Received down"
    when Curses::KEY_UP, "k"
      direction = Snake::UP
      logger.info "Received up"
    when 27
      menu = MenuWindow.new
      menu.doMenu
    when "Q"
      break
    end

    logger.info "Direction is #{direction}"
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