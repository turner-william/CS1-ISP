import Igis
import Foundation
import Scenes

class Score: RenderableEntity{
    var gameover: Bool = false
    var printedWords : String = ""
    var score : Int = 0
    var gameEnded = false
    var firstGame = true
    
    init(){
        super.init(name:"Score")
        score = 0
    }
    override func setup(canvasSize: Size, canvas: Canvas){
        score = 0
    }
    override func render(canvas: Canvas){
        if let canvasSize = canvas.canvasSize{
            let gameoverText = Text(location:Point(x:5, y:35), text: "\(printedWords) \(score)")
            gameoverText.font = "30pt Arial"
            canvas.render(gameoverText)
            if gameover == true{
                gameEnded = true
                firstGame = false
            }
            if gameover == false && gameEnded == true && firstGame == false{
                score = 0
                gameEnded = false
            }
        }
    }
}
