import Igis
import Foundation
import Scenes

class Player1: RenderableEntity{
    //creating useful variables to manipulate the player
    var imageURL: URL
    //let image = Image(sourceURL: imageURL)
    let image : Image
    let imageTopLeft = Point(x:0, y:0)
    
    //using a 4:3 aspect ratio
    let imageWidth = 300
    let imageHeight = 225
    
    
    init() {
        // Using a meaningful name can be helpful for debugging
        imageURL = URL(fileURLWithPath: "bread.png")
        super.init(name:"Player1")
    }
    override func setup(canvasSize: Size, canvas: Canvas) {
    }
    override func render(canvas:Canvas) {
        /*if image.isReady{
            canvas.render()
            }
            
         */
        print(imageURL)
    }
}
