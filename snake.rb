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
  direction = snake.randDirection
  logger.info "Direction: #{direction}"
  add = true

  # Main Game Loop

  while (running) do
    char = win.mainWindow.getch
    logger.info "char: #{char}"

    # Change Direction
    case char
    when Curses::KEY_LEFT, "h"
      if snake.direction != Snake::RIGHT
        direction = Snake::LEFT
      end
      logger.info "Received left"
    when Curses::KEY_RIGHT, "l"
      if snake.direction != Snake::LEFT
        direction = Snake::RIGHT
      end
      logger.info "Received right"
    when Curses::KEY_DOWN, "j"
      if snake.direction != Snake::UP
        direction = Snake::DOWN
      end
      logger.info "Received down"
    when Curses::KEY_UP, "k"
      if snake.direction != Snake::DOWN
        direction = Snake::UP
      end
      logger.info "Received up"
    when 27
      menu = MenuWindow.new
      menu.doMenu
    when "Q"
      break
    end

    logger.info "Direction is #{direction}"
    snake.direction = direction
    win.mainWindow.clear
    win.mainWindow.box("|", "-")
    win.printChar(win.food.symbol, win.food.y, win.food.x)
    snake.next(win)
    snake.body.each { |segment| 
      logger.info "Segment y: #{segment.y} Segment x: #{segment.x}"
      win.printChar(snake.symbol, segment.y, segment.x)
    }
    win.mainWindow.refresh
    logger.info "FoodY: #{win.food.y} FoodX: #{win.food.x} "
    if snake.body.last.x == win.food.x && snake.body.last.y == win.food.y
      logger.info "--- FOOD EATEN ---"
      win.food.newFood
      snake.addSegment(win)
    end
    sleep 0.1
  end
ensure
  Curses.close_screen
end