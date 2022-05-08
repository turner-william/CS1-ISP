import Igis
import Foundation
import Scenes

class Enemy: RenderableEntity {
    var gameover: Bool = false
    //useful variables to manipulate enemy
    let image : Image
    var imageTopLeft = Point(x:0, y:0)
    var canvasImageCenter = Point(x:0, y:0)
    var initialImageX : Int = 0
    
    let imageWidth = 80
    let imageHeight = 60
      
    init(){
        guard let imageURL = URL(string:"https://raw.githubusercontent.com/turner-william/CS1-ISP/master/Sources/Assets/Enemy.png") else{
            fatalError("enemy image failed to load")
        }
        image = Image(sourceURL:imageURL)
        super.init(name:"Enemy")
    }
    override func setup(canvasSize: Size, canvas: Canvas){
        canvas.setup(image)
    }
    override func boundingRect() -> Rect {
        return Rect(topLeft:imageTopLeft, size: Size(width: imageWidth, height: imageHeight))
    }
    override func render(canvas: Canvas){
        if gameover == false{
            if let canvasSize = canvas.canvasSize{
                //centering image on the canvas
                canvasImageCenter = Point(x: canvasSize.width - imageWidth, y: ((canvasSize.height / 2) - (imageWidth / 2)) + (canvasSize.height / 10))
                if imageTopLeft.x == 0{
                    imageTopLeft = canvasImageCenter
                    initialImageX = imageTopLeft.x
                }
                
                if image.isReady{
                    image.renderMode = .destinationRect(Rect(topLeft:imageTopLeft, size:Size(width: imageWidth, height: imageHeight)))
                    canvas.render(image)
                } else{
                    let enemyLoadingText = Text(location:Point(x:canvasSize.width / 2, y: 100), text: "Enemy Loading")
                    enemyLoadingText.font = "30pt Arial"
                    enemyLoadingText.alignment = .center
                    canvas.render(enemyLoadingText)
                }
            }
        }
    }
    override func calculate(canvasSize: Size){
        if imageTopLeft.x + imageWidth <= 0{
            imageTopLeft.x = canvasImageCenter.x
        } else{
            imageTopLeft.x -= 20
        }
        imageTopLeft.y = canvasImageCenter.y
    }
}
