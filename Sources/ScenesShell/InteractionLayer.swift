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
            enemy1.gameover = false
            enemy2.gameover = false
            enemy3.gameover = false
            enemy4.gameover = false
            gameOverText.gameover = false
            gameOverInstructions.gameover = false
            score.gameover = false
        }
    }
    override func preCalculate(canvas:Canvas){
        if let canvasSize = canvas.canvasSize{
            if enemy3.isActive == false && enemy1.imageTopLeft.x < canvasSize.width / 2 && score.score > 10{
                enemy3.isActive = true
                enemy4.isActive = true
            }
        }
        if score.gameover == false{
            score.score += 1
        }
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
            gameOverText.gameover = true
            gameOverInstructions.gameover = true
            score.gameover = true
        }

        enemyBoundingRect = enemy2.boundingRect()
        playerContainment = playerBoundingRect.containment(target: enemyBoundingRect)
        if playerTargetContainmentSet.isSubset(of: playerContainment) || playerTargetContainmentSet2.isSubset(of: playerContainment){
            player.gameover = true
            enemy1.gameover = true
            enemy2.gameover = true
            enemy3.gameover = true
            enemy4.gameover = true
            gameOverText.gameover = true
            gameOverInstructions.gameover = true
            score.gameover = true
        }

        enemyBoundingRect = enemy3.boundingRect()
        playerContainment = playerBoundingRect.containment(target: enemyBoundingRect)
        if playerTargetContainmentSet.isSubset(of: playerContainment) || playerTargetContainmentSet2.isSubset(of: playerContainment){
            player.gameover = true
            enemy1.gameover = true
            enemy2.gameover = true
            enemy3.gameover = true
            enemy4.gameover = true
            gameOverText.gameover = true
            gameOverInstructions.gameover = true
            score.gameover = true
        }

        enemyBoundingRect = enemy4.boundingRect()
        playerContainment = playerBoundingRect.containment(target: enemyBoundingRect)
        if playerTargetContainmentSet.isSubset(of: playerContainment) || playerTargetContainmentSet2.isSubset(of: playerContainment){
            player.gameover = true
            enemy1.gameover = true
            enemy2.gameover = true
            enemy3.gameover = true
            enemy4.gameover = true
            gameOverText.gameover = true
            gameOverInstructions.gameover = true
            score.gameover = true
        }
    }
}
