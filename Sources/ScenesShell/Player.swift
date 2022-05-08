import Igis
import Foundation
import Scenes

class Player: RenderableEntity{
    var gameover: Bool = false
    var gameStarted = false
    //creating useful variables to manipulate the image/player
    let image : Image
    var imageTopLeft = Point(x:0, y:0)
    var canvasImageCenter = Point(x: 0, y: 0)
    var initialImageY : Int = 0
    var hitJumpPeak = false

    //jumping variables
    var atPeakLength : Int = 0
    var keyMove : Int = 0
    var keyMove1 : Bool = false
    var keyMove2 : Bool = false
    var keyMove3 : Bool = false
    
    //using a 4:3 aspect ratio
    let imageWidth = 120
    let imageHeight = 90


    init() {
        //getting the image url ready
        guard let imageURL = URL(string:"https://github.com/turner-william/CS1-ISP/blob/master/Sources/Assets/willPlayer.png?raw=true") else{
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
        if gameover == false{
            if let canvasSize = canvas.canvasSize{
                //centering image on the canvas
                canvasImageCenter = Point(x: (canvasSize.width / 2) - (imageWidth / 2), y: ((canvasSize.height / 2) - (imageWidth / 2)) + (canvasSize.height / 16))
                if imageTopLeft.x == 0{
                    imageTopLeft = canvasImageCenter
                    initialImageY = imageTopLeft.y
                }
                
                //rendinging image if its ready
                if gameStarted == true{
                    if image.isReady{
                        image.renderMode = .destinationRect(Rect(topLeft:imageTopLeft, size:Size(width: imageWidth, height: imageHeight)))
                        canvas.render(image)
                    } else{
                        let playerLoadingText = Text(location: Point(x: canvasSize.width / 2, y: 150), text: "Player Loading")
                        playerLoadingText.font = "30pt Arial"
                        playerLoadingText.alignment = .center
                        canvas.render(playerLoadingText)       
                    }
                }
            }
        }
    }
    override func calculate(canvasSize: Size){
        canvasImageCenter = Point(x: (canvasSize.width / 2) - (imageWidth / 2), y: (canvasSize.height / 2) - (imageWidth / 2))
        if ((keyMove == 1 && keyMove2 == false) || keyMove1 == true) && keyMove3 == false{
            keyMove1 = true
            imageTopLeft.y -= 1
            if initialImageY > imageTopLeft.y && initialImageY - 200 <= imageTopLeft.y && hitJumpPeak == false{
                if Int(sqrt(Double(imageTopLeft.y - (initialImageY - 200))) * 2) >= 3{
                    imageTopLeft.y -= Int(sqrt(Double(imageTopLeft.y - (initialImageY - 200))) * 2)
                    hitJumpPeak = false
                } else{
                    imageTopLeft.y -= 3
                }
            } else if initialImageY > imageTopLeft.y && initialImageY - 200 > imageTopLeft.y{
                hitJumpPeak = true
                imageTopLeft.y = initialImageY - 200
            }
            if hitJumpPeak == true{
                if atPeakLength > 1{
                    if sqrt(Double(imageTopLeft.y - (initialImageY - 200))) * 2 >= 3{
                        imageTopLeft.y += Int(sqrt(Double(imageTopLeft.y - (initialImageY - 200))) * 2)
                    } else {
                        imageTopLeft.y += 3
                    }
                } else{
                    atPeakLength += 1
                }
            }
            if initialImageY < imageTopLeft.y{
                imageTopLeft.y = initialImageY
                hitJumpPeak = false
                atPeakLength = 0
                keyMove1 = false
                keyMove = 0
            }
        } else if ((keyMove == 2 && keyMove1 == false) || keyMove2 == true) && keyMove3 == false{
            keyMove2 = true
            imageTopLeft.y -= 1
            if initialImageY > imageTopLeft.y && initialImageY - 400 <= imageTopLeft.y && hitJumpPeak == false{
                if Int(sqrt(Double(imageTopLeft.y - (initialImageY - 400))) * 2) >= 3{
                    imageTopLeft.y -= Int(sqrt(Double(imageTopLeft.y - (initialImageY - 400))) * 2)
                    hitJumpPeak = false
                } else{
                    imageTopLeft.y -= 3
                }
            } else if initialImageY > imageTopLeft.y && initialImageY - 400 > imageTopLeft.y{
                hitJumpPeak = true
                imageTopLeft.y = initialImageY - 400
            }
            if hitJumpPeak == true{
                if atPeakLength > 1{
                    if sqrt(Double(imageTopLeft.y - (initialImageY - 400))) * 2 >= 3{
                        imageTopLeft.y += Int(sqrt(Double(imageTopLeft.y - (initialImageY - 400))) * 2)
                    } else {
                        imageTopLeft.y += 3
                    }
                } else{
                    atPeakLength += 1
                }
            }
            if initialImageY < imageTopLeft.y{
                imageTopLeft.y = initialImageY
                hitJumpPeak = false
                atPeakLength = 0
                keyMove2 = false
                keyMove = 0
            }
        }
        if (keyMove == 3 && imageTopLeft.y + 35 < initialImageY) || keyMove3 == true{
            keyMove3 = true
            keyMove2 = false
            keyMove1 = false
            imageTopLeft.y += 35
        }
        if keyMove3 == true && imageTopLeft.y + 35 >= initialImageY{
            imageTopLeft.y = initialImageY
            hitJumpPeak = false
            keyMove3 = false
        }
    }
}
