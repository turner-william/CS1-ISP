import Scenes
import Igis
import Foundation

/*
 This class is responsible for the interaction Layer.
 Internally, it maintains the RenderableEntities for this layer.
 */


class InteractionLayer : Layer, KeyDownHandler {
    let player = Player()
    let enemy = Enemy()
    let gameOverText = gameText()
    let gameOverInstructions = gameText()
    let score = Score()
    
    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Interaction")

        // We insert our RenderableEntities in the constructor
        insert(entity: player, at: .front)
        insert(entity: enemy, at: .front)
        insert(entity: gameOverText, at: .front)
        insert(entity: gameOverInstructions, at: .front)
        insert(entity: score, at: .front)
    }
    override func preSetup(canvasSize: Size, canvas: Canvas){
        dispatcher.registerKeyDownHandler(handler: self)
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
        if code == "Space"{
            player.imageTopLeft.y -= 5
        }
        if code == "Enter"{
            enemy.imageTopLeft = enemy.canvasImageCenter
            player.gameover = false
            enemy.gameover = false
            gameOverText.gameover = false
            gameOverInstructions.gameover = false
            score.gameover = false
        }
    }
    override func preCalculate(canvas:Canvas){
        if score.gameover == false{
            score.score += 1
        }
        let playerBoundingRect = player.boundingRect()
        let enemyBoundingRect = enemy.boundingRect()

        let playerContainment = playerBoundingRect.containment(target: enemyBoundingRect)
        let playerTargetContainmentSet: ContainmentSet = [.overlapsLeft, .contact]
        let playerTargetContainmentSet2: ContainmentSet = [.overlapsRight, .contact]
        if playerTargetContainmentSet.isSubset(of: playerContainment) || playerTargetContainmentSet2.isSubset(of: playerContainment){
            player.gameover = true
            enemy.gameover = true
            gameOverText.gameover = true
            gameOverInstructions.gameover = true
            score.gameover = true
        }
    }
}
