import Scenes
import Foundation
import Igis

class StartScreen: RenderableEntity {
    var gameStarted = false
    
    init() {
        super.init(name:"StartScreen")
    }
    
    override func render(canvas: Canvas){
        if let canvasSize = canvas.canvasSize{
            if  gameStarted == false{
                let gameWelcomeText = Text(location:Point(x:canvasSize.width / 2, y: canvasSize.height / 2 - 70), text:"Welcome to Dino Game")
                gameWelcomeText.font = "30pt Arial"
                gameWelcomeText.alignment = .center

                let controlsText = Text(location:Point(x:canvasSize.width / 2, y: canvasSize.height / 2 - 35), text:"Controls:")
                controlsText.font = "15pt Arial"
                controlsText.alignment = .center

                let controlsText2 = Text(location:Point(x:canvasSize.width / 2, y: canvasSize.height / 2 - 15), text:"Press 'Z' to Jump")
                controlsText2.font = "15pt Arial"
                controlsText2.alignment = .center

                let controlsText3 = Text(location:Point(x:canvasSize.width / 2, y: canvasSize.height / 2 + 5), text:"Press 'X' to Super Jump")
                controlsText3.font = "15pt Arial"
                controlsText3.alignment = .center

                let controlsText4 = Text(location:Point(x:canvasSize.width / 2, y: canvasSize.height / 2 + 25), text:"Press 'C' to Ground Slam")
                controlsText4.font = "15pt Arial"
                controlsText4.alignment = .center

                let controlsText5 = Text(location:Point(x:canvasSize.width / 2, y: canvasSize.height / 2 + 45), text:"Press 'T' to cycle through characters")
                controlsText5.font = "15pt Arial"
                controlsText5.alignment = .center

                let controlsText6 = Text(location:Point(x:canvasSize.width / 2, y: canvasSize.height / 2 + 65), text:"('Space' to Start game")
                controlsText6.font = "15pt Arial"
                controlsText6.alignment = .center

                canvas.render(gameWelcomeText, controlsText, controlsText2, controlsText3, controlsText4, controlsText5, controlsText6)
            }
        }
        
    }
}
