import Igis
import Foundation
import Scenes

class Score: RenderableEntity{
    var gameover: Bool = false
    var printedWords : String = ""
    var score : Int = 0
    var gameEnded = false
    init(){
        super.init(name:"Score")
    }
    override func render(canvas: Canvas){
        score += 1
        if let canvasSize = canvas.canvasSize{
            let gameoverText = Text(location:Point(x:0, y:0), text: "/(printedWords) /(score)")
            gameoverText.font = "30pt Arial"
            canvas.render(gameoverText)
            if gameover = true{
                gameEnded = true
            }
            if gameover = false && gameEnded = false{
                score = 0
                gameEnded = false
            }
        }
    }
}
