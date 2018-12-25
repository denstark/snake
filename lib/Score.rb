require 'singleton'

class Score
  include Singleton
  SCORES_DIR="#{Dir.home}/.snake"
  SCORES_FILE="#{SCORES_DIR}/scores"
  
  attr_accessor :curScore, :hiScore
  def initialize
    @hiScore = self.readScoreFromFile
    @curScore = 0
  end

  def addToCurScore(val)
    @curScore += val
  end

  def makeSnakeDir
    if !Dir.exist?(SCORES_DIR)
      Dir.mkdir(SCORES_DIR)
    end
  end

  def readScoreFromFile
    if File.exists?(SCORES_FILE)
      return File.open(SCORES_FILE) {|f| f.readline }
    else
      return 0
    end
  end

  def writeScoreToFile
    self.makeSnakeDir
    File.open(SCORES_FILE, 'w') {|f| f.write(@hiScore)}
  end

  def checkHiScore
    if @curScore.to_i > @hiScore.to_i
      self.hiScore = @curScore
    end
  end
end