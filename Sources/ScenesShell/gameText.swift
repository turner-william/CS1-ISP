import Igis
import Foundation
import Scenes

class gameText: RenderableEntity{
    var gameover: Bool = false
    var printedWords : String = ""
    var fontSize = ""
    var wordLocation = Point(x:0, y:0)
    var highscore = false
    
    init(){
        super.init(name:"gameText")
    }
    override func render(canvas: Canvas){
            let gameoverText = Text(location:wordLocation, text: printedWords)
            gameoverText.font = fontSize
            gameoverText.alignment = .center
            if highscore == true{
                gameoverText.alignment = .left
            }
            if gameover == true || highscore == true{
                canvas.render(gameoverText)
            }
    }
}
