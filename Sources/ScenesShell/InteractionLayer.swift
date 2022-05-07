import Scenes
import Igis
import Foundation

/*
 This class is responsible for the interaction Layer.
 Internally, it maintains the RenderableEntities for this layer.
 */


class InteractionLayer : Layer, KeyDownHandler {
    let player = Player()

    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Interaction")

        // We insert our RenderableEntities in the constructor
        insert(entity: player, at: .front)
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
    }
}
