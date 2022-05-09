import Scenes
import Igis
import Foundation

/*
 This class is responsible for rendering the background.
 */


class Background : RenderableEntity {
    let backgroundSound: Audio
    var isBackgroundPlaying = false
    let backgroundImage : Image
    
    init() {
        //creating sound url
        guard let sound = URL(string:"https://codermerlin.com/users/william-turner/CoconutMall.mp3") else{
            fatalError("Sound could not be loaded")
        }
        backgroundSound = Audio(sourceURL:sound, shouldLoop:true)
        
        //creating background url
        guard let image = URL(string:"https://github.com/turner-william/CS1-ISP/blob/master/Sources/Assets/Background.png?raw=true") else{
            fatalError("Background Image could not be loaded")
        }
        backgroundImage = Image(sourceURL:image)
        
        super.init(name:"Background")
    }
    override func setup(canvasSize: Size, canvas: Canvas){
        canvas.setup(backgroundSound)
        canvas.setup(backgroundImage)
    }
    override func render(canvas: Canvas){

        if let canvasSize = canvas.canvasSize{
            if backgroundImage.isReady{
                backgroundImage.renderMode = .destinationRect(Rect(topLeft: Point(x:0, y:0), size:Size(width:canvasSize.width, height:canvasSize.height)))
                canvas.render(backgroundImage)
            } else{
                let backgroundLoadingText = Text(location:Point(x: canvasSize.width / 2, y: 50), text:"Background Loading")
                backgroundLoadingText.font = "30pt Arial"
                backgroundLoadingText.alignment = .center
                canvas.render(backgroundLoadingText)
            }
        }
        if !isBackgroundPlaying && backgroundSound.isReady {
            canvas.render(backgroundSound)
            isBackgroundPlaying = true
        }

    }
    
}
