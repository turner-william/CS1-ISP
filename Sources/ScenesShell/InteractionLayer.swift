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
    let text = gameText()

    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Interaction")

        // We insert our RenderableEntities in the constructor
        insert(entity: player, at: .front)
        insert(entity: enemy, at: .front)
        insert(entity: text, at: .front)
    }
    override func preSetup(canvasSize: Size, canvas: Canvas){
        dispatcher.registerKeyDownHandler(handler: self)
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
            text.gameover = false
        }
    }
    override func preCalculate(canvas:Canvas){
        let playerBoundingRect = player.boundingRect()
        let enemyBoundingRect = enemy.boundingRect()

        let playerContainment = playerBoundingRect.containment(target: enemyBoundingRect)
        let playerTargetContainmentSet: ContainmentSet = [.overlapsLeft, .contact]
        let playerTargetContainmentSet2: ContainmentSet = [.overlapsRight, .contact]
        if playerTargetContainmentSet.isSubset(of: playerContainment) || playerTargetContainmentSet2.isSubset(of: playerContainment){
            player.gameover = true
            enemy.gameover = true
            text.gameover = true
        }
    }
}
