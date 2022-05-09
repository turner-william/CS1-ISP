import Igis
import Foundation
import Scenes

class Player: RenderableEntity{
    var jumpHeight1 = 0
    var jumpHeight2 = 0
    var gameover: Bool = false
    var gameStarted = false
    var characterNumber = 1
    //creating useful variables to manipulate the image/players
    let image1 : Image
    let image2 : Image
    let image3 : Image
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
        guard let image1URL = URL(string:"https://github.com/turner-william/CS1-ISP/blob/master/Sources/Assets/willPlayer.png?raw=true") else{
            fatalError("Failed to create URL for Player 1 image")
        }
        image1 = Image(sourceURL:image1URL)
        
        guard let image2URL = URL(string:"https://github.com/turner-william/CS1-ISP/blob/master/Sources/Assets/nahomPlayer.png?raw=true") else{
            fatalError("Failed to create URL for Player 2 image")
        }
        image2 = Image(sourceURL:image2URL)
        
        guard let image3URL = URL(string:"https://github.com/turner-william/CS1-ISP/blob/master/Sources/Assets/billyPlayer.png?raw=true") else{
            fatalError("Failed to create URL for Player 3 image")
        }
        image3 = Image(sourceURL:image3URL)
        super.init(name:"Player")
    }

    //setting up image to be ready
    override func setup(canvasSize: Size, canvas: Canvas) {
        canvas.setup(image1)
        canvas.setup(image2)
        canvas.setup(image3)
        jumpHeight1 = (canvasSize.height / 100) * 19
        jumpHeight2 = (canvasSize.height / 100) * 37
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
                    if image1.isReady && characterNumber == 1{
                        image1.renderMode = .destinationRect(Rect(topLeft:imageTopLeft, size:Size(width: imageWidth, height: imageHeight)))
                        canvas.render(image1)
                    } else if image2.isReady && characterNumber == 2{
                        image2.renderMode = .destinationRect(Rect(topLeft:imageTopLeft, size:Size(width: imageWidth, height: imageHeight)))
                        canvas.render(image2)
                    } else if image3.isReady && characterNumber == 3{
                        image3.renderMode = .destinationRect(Rect(topLeft:imageTopLeft, size:Size(width: imageWidth, height: imageHeight)))
                        canvas.render(image3)
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
            if initialImageY > imageTopLeft.y && initialImageY - jumpHeight1 <= imageTopLeft.y && hitJumpPeak == false{
                if Int(sqrt(Double(imageTopLeft.y - (initialImageY - jumpHeight1))) * 2) >= 3{
                    imageTopLeft.y -= Int(sqrt(Double(imageTopLeft.y - (initialImageY - jumpHeight1))) * 2)
                    hitJumpPeak = false
                } else{
                    imageTopLeft.y -= 3
                }
            } else if initialImageY > imageTopLeft.y && initialImageY - jumpHeight1 > imageTopLeft.y{
                hitJumpPeak = true
                imageTopLeft.y = initialImageY - jumpHeight1
            }
            if hitJumpPeak == true{
                if atPeakLength > 1{
                    if sqrt(Double(imageTopLeft.y - (initialImageY - jumpHeight1))) * 2 >= 3{
                        imageTopLeft.y += Int(sqrt(Double(imageTopLeft.y - (initialImageY - jumpHeight1))) * 2)
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
            if initialImageY > imageTopLeft.y && initialImageY - jumpHeight2 <= imageTopLeft.y && hitJumpPeak == false{
                if Int(sqrt(Double(imageTopLeft.y - (initialImageY - jumpHeight2))) * 2) >= 3{
                    imageTopLeft.y -= Int(sqrt(Double(imageTopLeft.y - (initialImageY - jumpHeight2))) * 2)
                    hitJumpPeak = false
                } else{
                    imageTopLeft.y -= 3
                }
            } else if initialImageY > imageTopLeft.y && initialImageY - jumpHeight2 > imageTopLeft.y{
                hitJumpPeak = true
                imageTopLeft.y = initialImageY - jumpHeight2
            }
            if hitJumpPeak == true{
                if atPeakLength > 1{
                    if sqrt(Double(imageTopLeft.y - (initialImageY - jumpHeight2))) * 2 >= 3{
                        imageTopLeft.y += Int(sqrt(Double(imageTopLeft.y - (initialImageY - jumpHeight2))) * 2)
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
