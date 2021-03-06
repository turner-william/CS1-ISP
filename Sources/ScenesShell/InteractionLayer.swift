import Scenes
import Igis
import Foundation

/*
 This class is responsible for the interaction Layer.
 Internally, it maintains the RenderableEntities for this layer.
 */


class InteractionLayer : Layer, KeyDownHandler {
    let player = Player()
    let enemy1 = Enemy()
    let enemy2 = Enemy()
    let enemy3 = Enemy()
    let enemy4 = Enemy()
    
    let gameOverText = gameText()
    let gameOverInstructions = gameText()
    let score = Score()
    let startScreen = StartScreen()
    
    var enemyY1 = 0
    var enemyY2 = 0
    var enemyY3 = 0
    let highScore = gameText()
    var highscore = 0
    
    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Interaction")

        // We insert our RenderableEntities in the constructor
        insert(entity: player, at: .front)
        insert(entity: enemy1, at: .front)
        insert(entity: enemy2, at: .front)
        insert(entity: enemy3, at: .front)
        insert(entity: enemy4, at: .front)
        
        insert(entity: gameOverText, at: .front)
        insert(entity: gameOverInstructions, at: .front)
        insert(entity: score, at: .front)
        insert(entity: highScore, at: .front)
        insert(entity: startScreen, at: .front)
    }
    override func preSetup(canvasSize: Size, canvas: Canvas){
        dispatcher.registerKeyDownHandler(handler: self)

        enemy1.isActive = true
        enemy2.isActive = true
        gameOverText.printedWords = "Game Over"
        gameOverText.fontSize = "30pt Arial"
        gameOverText.wordLocation = Point(x:canvasSize.width / 2, y:canvasSize.height / 2)
          
        gameOverInstructions.printedWords = "(Press 'Enter' to play again)"
        gameOverInstructions.fontSize = "12pt Arial"
        gameOverInstructions.wordLocation = Point(x:canvasSize.width / 2, y:(canvasSize.height / 2) + 17)
        score.printedWords = "Score:"
        highScore.printedWords = "Highscore: \(highscore)"
        highScore.fontSize = "15pt Arial"
        highScore.highscore = true
        highScore.wordLocation = Point(x:50, y: 85)

        enemyY1 = canvasSize.height / 7
        enemyY2 = canvasSize.height / 3
        enemyY3 = canvasSize.height / 2
    }
    override func postTeardown() {
        dispatcher.unregisterKeyDownHandler(handler: self)
    }
    func onKeyDown(key:String, code:String, ctrlKey:Bool, shiftKey:Bool,  altKey:Bool, metaKey:Bool){
        if code == "KeyZ"{
            player.keyMove = 1
        } else if code == "KeyX"{
            player.keyMove = 2
        }
        if code == "KeyC"{
            player.keyMove = 3
        }
        if code == "Enter"{
            enemy1.imageTopLeft = enemy1.canvasImageCenter
            enemy2.imageTopLeft = enemy2.canvasImageCenter
            enemy3.imageTopLeft = enemy3.canvasImageCenter
            enemy4.imageTopLeft = enemy4.canvasImageCenter
            enemy3.isActive = false
            enemy4.isActive = false
            player.imageTopLeft.y = player.initialImageY
            score.score = 0
            player.keyMove1 = false
            player.keyMove2 = false
            player.keyMove3 = false
            player.keyMove = 0
            player.gameover = false
            player.hitJumpPeak = false
            enemy1.gameover = false
            enemy2.gameover = false
            enemy3.gameover = false
            enemy4.gameover = false
            gameOverText.gameover = false
            gameOverInstructions.gameover = false
            score.gameover = false
            highScore.gameover = false
        }
        if code == "Space"{
            startScreen.gameStarted = true
            player.gameStarted = true
            enemy1.gameStarted = true
            enemy2.gameStarted = true
            enemy3.gameStarted = true
            enemy4.gameStarted = true
        }
        if code == "KeyT"{
            if player.characterNumber < 3{
                player.characterNumber += 1
            } else {
                player.characterNumber = 1
            }
        }
    }
    override func preCalculate(canvas:Canvas){
        if score.score == 500{
            enemy1.speed += 5
            enemy2.speed += 5
            enemy3.speed += 5
            enemy4.speed += 5
        } else if score.score == 1000{
            enemy1.speed += 5
            enemy2.speed += 5
            enemy3.speed += 5
            enemy4.speed += 5
        } else if score.score == 1500{
            enemy1.speed += 5
            enemy2.speed += 5
            enemy3.speed += 5
            enemy4.speed += 5
        } else if score.score == 2000{
            enemy1.speed += 5
            enemy2.speed += 5
            enemy3.speed += 5
            enemy4.speed += 5
        } else if score.score == 2000{
            enemy1.speed += 5
            enemy2.speed += 5
            enemy3.speed += 5
            enemy4.speed += 5
        }
        if enemy1.screenReset == true{
            repeat{
                let rn1 = Int.random(in:1...3)
                let rn2 = Int.random(in:1...3)
                if rn1 == 1{
                    enemy1.enemyY = enemyY1
                } else if rn1 == 2{
                    enemy1.enemyY = enemyY2
                } else if rn1 == 3{
                    enemy1.enemyY = enemyY3
                }
                
                if rn2 == 1{
                    enemy2.enemyY = enemyY1
                } else if rn2 == 2{
                    enemy2.enemyY = enemyY2
                } else if rn2 == 3{
                    enemy2.enemyY = enemyY3
                }
            } while enemy1.enemyY == enemy2.enemyY
            enemy1.screenReset = false
        }

        if enemy3.screenReset == true{
            repeat{
                let rn1 = Int.random(in:1...3)
                let rn2 = Int.random(in:1...3)
                if rn1 == 1{
                    enemy3.enemyY = enemyY1
                } else if rn1 == 2{
                    enemy3.enemyY = enemyY2
                } else if rn1 == 3{
                    enemy3.enemyY = enemyY3
                }
                
                if rn2 == 1{
                    enemy4.enemyY = enemyY1
                } else if rn2 == 2{
                    enemy4.enemyY = enemyY2
                } else if rn2 == 3{
                    enemy4.enemyY = enemyY3
                }
            } while enemy3.enemyY == enemy4.enemyY
            enemy3.screenReset = false
        }
        if let canvasSize = canvas.canvasSize{
            if enemy3.isActive == false && enemy1.imageTopLeft.x < canvasSize.width / 2 && score.score > 10{
                enemy3.isActive = true
                enemy4.isActive = true
            }
        }
        if enemy1.gameStarted == true{
            if score.gameover == false{
                score.score += 1
            }
        }
        if score.score >= highscore{
            highscore = score.score
        }
        highScore.printedWords = "Highscore: \(highscore)"
        let playerBoundingRect = player.boundingRect()
        var enemyBoundingRect = enemy1.boundingRect()

        var playerContainment = playerBoundingRect.containment(target: enemyBoundingRect)
        let playerTargetContainmentSet: ContainmentSet = [.overlapsLeft, .contact]
        let playerTargetContainmentSet2: ContainmentSet = [.overlapsRight, .contact]
        if playerTargetContainmentSet.isSubset(of: playerContainment) || playerTargetContainmentSet2.isSubset(of: playerContainment){
            player.gameover = true
            enemy1.gameover = true
            enemy2.gameover = true
            enemy3.gameover = true
            enemy4.gameover = true
            enemy3.isActive = false
            enemy4.isActive = false
            player.keyMove1 = false
            player.keyMove2 = false
            player.keyMove3 = false
            player.keyMove = 0
            player.hitJumpPeak = false
            gameOverText.gameover = true
            gameOverInstructions.gameover = true
            score.gameover = true
            highScore.gameover = true
            enemy1.speed = 20
            enemy2.speed = 20
            enemy3.speed = 20
            enemy4.speed = 20
        }

        enemyBoundingRect = enemy2.boundingRect()
        playerContainment = playerBoundingRect.containment(target: enemyBoundingRect)
        if playerTargetContainmentSet.isSubset(of: playerContainment) || playerTargetContainmentSet2.isSubset(of: playerContainment){
            player.gameover = true
            enemy1.gameover = true
            enemy2.gameover = true
            enemy3.gameover = true
            enemy4.gameover = true
            player.keyMove1 = false
            player.keyMove2 = false
            player.keyMove3 = false
            player.keyMove = 0
            player.hitJumpPeak = false
            gameOverText.gameover = true
            gameOverInstructions.gameover = true
            score.gameover = true
            highScore.gameover = true
            enemy1.speed = 20
            enemy2.speed = 20
            enemy3.speed = 20
            enemy4.speed = 20
        }

        enemyBoundingRect = enemy3.boundingRect()
        playerContainment = playerBoundingRect.containment(target: enemyBoundingRect)
        if playerTargetContainmentSet.isSubset(of: playerContainment) || playerTargetContainmentSet2.isSubset(of: playerContainment){
            player.gameover = true
            enemy1.gameover = true
            enemy2.gameover = true
            enemy3.gameover = true
            enemy4.gameover = true
            player.keyMove1 = false
            player.keyMove2 = false
            player.keyMove3 = false
            player.keyMove = 0
            player.hitJumpPeak = false
            gameOverText.gameover = true
            gameOverInstructions.gameover = true
            score.gameover = true
            highScore.gameover = true
            enemy1.speed = 20
            enemy2.speed = 20
            enemy3.speed = 20
            enemy4.speed = 20
        }

        enemyBoundingRect = enemy4.boundingRect()
        playerContainment = playerBoundingRect.containment(target: enemyBoundingRect)
        if playerTargetContainmentSet.isSubset(of: playerContainment) || playerTargetContainmentSet2.isSubset(of: playerContainment){
            player.gameover = true
            enemy1.gameover = true
            enemy2.gameover = true
            enemy3.gameover = true
            enemy4.gameover = true
            player.keyMove1 = false
            player.keyMove2 = false
            player.keyMove3 = false
            player.keyMove = 0
            player.hitJumpPeak = false
            gameOverText.gameover = true
            gameOverInstructions.gameover = true
            score.gameover = true
            highScore.gameover = true
            enemy1.speed = 20
            enemy2.speed = 20
            enemy3.speed = 20
            enemy4.speed = 20
        }
    }
}
