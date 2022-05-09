import Scenes
import Foundation
import Igis

class StartScreen: RenderableEntity {
    var gameStarted = false
    
    init() {
        super.init(name:"StartScreen")
    }
    
    override func render(canvas: Canvas){
        var controlsText2 = Text(location:Point(x:0,y:0), text:"")
        var controlsText3 = Text(location:Point(x:0,y:0), text:"")
        var controlsText4 = Text(location:Point(x:0,y:0), text:"")
        var controlsText5 = Text(location:Point(x:0,y:0), text:"")
        
        if let canvasSize = canvas.canvasSize{
            if gameStarted == false{
                let gameWelcomeText = Text(location:Point(x:canvasSize.width / 2, y: canvasSize.height / 2 - 70), text:"Welcome to Dino Game")
                gameWelcomeText.font = "30pt Arial"
                gameWelcomeText.alignment = .center

                let controlsText = Text(location:Point(x:canvasSize.width / 2, y: canvasSize.height / 2 - 35), text:"Controls:")
                controlsText.font = "15pt Arial"
                controlsText.alignment = .center

                controlsText2 = Text(location:Point(x:canvasSize.width / 2, y: canvasSize.height / 2 - 15), text:"Press 'Z' to Jump")
                controlsText2.font = "15pt Arial"
                controlsText2.alignment = .center

                controlsText3 = Text(location:Point(x:canvasSize.width / 2, y: canvasSize.height / 2 + 5), text:"Press 'X' to Super Jump")
                controlsText3.font = "15pt Arial"
                controlsText3.alignment = .center

                controlsText4 = Text(location:Point(x:canvasSize.width / 2, y: canvasSize.height / 2 + 25), text:"Press 'C' to Ground Slam")
                controlsText4.font = "15pt Arial"
                controlsText4.alignment = .center

                controlsText5 = Text(location:Point(x:canvasSize.width / 2, y: canvasSize.height / 2 + 45), text:"Press 'T' to cycle through characters")
                controlsText5.font = "15pt Arial"
                controlsText5.alignment = .center

                let controlsText6 = Text(location:Point(x:canvasSize.width / 2, y: canvasSize.height / 2 + 65), text:"('Space' to Start game")
                controlsText6.font = "15pt Arial"
                controlsText6.alignment = .center

                canvas.render(gameWelcomeText, controlsText, controlsText2, controlsText3, controlsText4, controlsText5, controlsText6)
            } else {
                controlsText2.location.x = 5
                controlsText2.location.y = canvasSize.height - 20
                controlsText2.alignment = .left
                controlsText2.text = "Press 'Z' to Jump"
                controlsText2.font = "15pt Arial"

                controlsText3.location.x = canvasSize.width / 3
                controlsText3.location.y = canvasSize.height - 20
                controlsText3.alignment = .left
                controlsText3.text = "Press 'X' to Super Jump"
                controlsText3.font = "15pt Arial"

                controlsText4.location.x = (canvasSize.width / 3) * 2
                controlsText4.location.y = canvasSize.height - 20
                controlsText4.alignment = .right
                controlsText4.text = "Press 'C' to Ground Slam"
                controlsText4.font = "15pt Arial"

                controlsText5.location.x = canvasSize.width - 5
                controlsText5.location.y = canvasSize.height - 20
                controlsText5.alignment = .right
                controlsText5.text = "Press 'T' to cycle  through characters"
                controlsText5.font = "15pt Arial"
                
                canvas.render(controlsText2, controlsText3, controlsText4, controlsText5)
            }
        }
        
    }
}
