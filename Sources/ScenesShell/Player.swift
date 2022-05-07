import Igis
import Foundation
import Scenes

class Player: RenderableEntity{
    //creating useful variables to manipulate the image/player
    let image : Image
    var imageTopLeft = Point(x:0, y:0)
    var canvasImageCenter = Point(x: 0, y: 0)
    var initialImageY : Int = 0
    var hitJumpPeak = false
    var atPeakLength : Int = 0

    //using a 4:3 aspect ratio
    let imageWidth = 300
    let imageHeight = 225


    init() {
        //getting the image url ready
        guard let imageURL = URL(string:"https://github.com/turner-william/CS1-ISP/blob/master/Sources/Assets/bread.jpg?raw=true") else{
            fatalError("Failed to create URL for Player 1 image")
        }
        image = Image(sourceURL:imageURL)
        super.init(name:"Player")
    }

    //setting up image to be ready
    override func setup(canvasSize: Size, canvas: Canvas) {
        canvas.setup(image)
    }

    //creating bounding rect
    override func boundingRect() -> Rect {
        return Rect(topLeft:imageTopLeft, size: Size(width: imageWidth, height:imageHeight))
    }
    override func render(canvas:Canvas) {
        if let canvasSize = canvas.canvasSize{
            //centering image on the canvas
            canvasImageCenter = Point(x: (canvasSize.width / 2) - (imageWidth / 2), y: (canvasSize.height / 2) - (imageWidth / 2))
            if imageTopLeft.x == 0{
                imageTopLeft = canvasImageCenter
                initialImageY = imageTopLeft.y
            }
        }
        //rendinging image if its ready
        if image.isReady{
            image.renderMode = .destinationRect(Rect(topLeft:imageTopLeft, size:Size(width: imageWidth, height: imageHeight)))
            canvas.render(image)
        } else{ print("image was not ready")}
    }
    override func calculate(canvasSize: Size){
        canvasImageCenter = Point(x: (canvasSize.width / 2) - (imageWidth / 2), y: (canvasSize.height / 2) - (imageWidth / 2))
        if initialImageY > imageTopLeft.y && initialImageY - 100 <= imageTopLeft.y && hitJumpPeak == false{
            if Int(sqrt(Double(imageTopLeft.y - (initialImageY - 100)))) >= 3{
                imageTopLeft.y -= Int(sqrt(Double(imageTopLeft.y - (initialImageY - 100))))
                hitJumpPeak = false
            } else{
                imageTopLeft.y -= 3
            }
        } else if initialImageY > imageTopLeft.y && initialImageY - 100 > imageTopLeft.y{
            hitJumpPeak = true
            imageTopLeft.y = initialImageY - 100
        }
        if hitJumpPeak == true{
            if atPeakLength > 5{
                if sqrt(Double(imageTopLeft.y - (initialImageY - 100))) >= 2{
                    imageTopLeft.y += Int(sqrt(Double(imageTopLeft.y - (initialImageY - 100))))
                } else {
                    imageTopLeft.y += 2
                }
            } else{
                atPeakLength += 1
            }
        }
        if initialImageY < imageTopLeft.y{
            imageTopLeft.y = initialImageY
            hitJumpPeak = false
            atPeakLength = 0
        }
    }
}
