import Igis
import Foundation
import Scenes

class gameText: RenderableEntity{
    var gameover: Bool = false
    var printedWords : String = ""
    init(){
        super.init(name:"gameText")
    }
    override func render(canvas: Canvas){
        if let canvasSize = canvas.canvasSize{
            let gameoverText = Text(location:Point(x:(canvasSize.width / 2) - (canvasSize.width / 10), y: canvasSize.height / 2), text: printedWords)
            gameoverText.font = "30pt Arial"
            if gameover == true{
                canvas.render(gameoverText)
            }
        }
    }
}
