require 'curses'
require 'require_all'
require_all 'lib/*.rb'
Curses.init_screen
Curses.curs_set 0 # Invisible Cursor
Curses.noecho
Curses.raw
Curses.ESCDELAY = 0
game = true
begin
while (game) do
  logger = SLogger.instance.logger
  logger.info "------- NEW GAME -------"
  screenWin = ScreenWindow.instance
  win = SnakeWindow.new
  snake = Snake.new
  scoreObj = Score.instance
  logger.info "High Score is: #{scoreObj.hiScore}"
  running = false
  direction = snake.randDirection
  mainMenu = MainMenuWindow.new
  r = mainMenu.doMenu
  case r
  when 'Q', 'q'
    break
  when 'N', 'n'
    running = true
  end
  
  while (running) do # Main Game Loop
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
      r = menu.doMenu
    end

    if r == 'Q'
      break
    end

    logger.info "Direction is #{direction}"
    snake.direction = direction
    win.mainWindow.clear
    win.mainWindow.box("|", "-")
    isDead = snake.next(win)
    snake.body.each { |segment| 
      logger.info "Segment y: #{segment.y} Segment x: #{segment.x}"
      win.printChar(snake.symbol, segment.y, segment.x)
    }
    if isDead == 0
      break
    end
    logger.info "FoodY: #{win.food.y} FoodX: #{win.food.x} "
    if snake.body.last.x == win.food.x && snake.body.last.y == win.food.y
      logger.info "--- FOOD EATEN ---"
      scoreObj.addToCurScore(1000)
      logger.info "Current Score: #{scoreObj.curScore}"
      win.food.newFood
      snake.addSegment(win)
    end
    scoreObj.checkHiScore
    win.printChar(win.food.symbol, win.food.y, win.food.x)

    # Print Scores
    screenWin.print(" " * 50, win.top - 1, win.left)
    screenWin.print("Score: #{scoreObj.curScore}", win.top - 1, win.left)
    hiScoreTxt = "High Score: #{scoreObj.hiScore}"
    screenWin.print(hiScoreTxt, win.top - 1, win.right - hiScoreTxt.length)
    screenWin.mainWindow.refresh

    win.mainWindow.refresh
    sleep 0.1
  end
  # Game over things can go here
  Curses::beep
  scoreObj.curScore = 0
  win.mainWindow.close
end
ensure
  Score.instance.writeScoreToFile
  Curses.close_screen
end