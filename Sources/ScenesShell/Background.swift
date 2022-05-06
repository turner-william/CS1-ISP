import Scenes
import Igis

/*
 This class is responsible for rendering the background.
 */


class Background : RenderableEntity {
    let background: Audio
    let isBackgroundPlaying = false
    init() {
        // Using a meaningful name can be helpful for debugging
        guard let sound = URL(string:"") else{
            fatalError("Sound could not be loaded")
        }
        background = Audio(sourceURL:sound, shouldLoop:true)
        super.init(name:"Background")
    }
    override func setup(size: CanvasSize, canvas: Canvas){
        canvas.setup(background)
    }
    override func render(canvas: Canvas){
        if let canvasSize = canvas.canvasSize{
            let backgroundRect = Rect(topLeft: Point(x:0, y:0), size: Size(width:canvasSize.width, height:canvasSize.height))
            let backgroundRectangle = Rectangle(rect:backgroundRect, fillMode: .fillAndStroke)
            let backgroundColor = Color(.green)
            canvas.render(FillStyle(color: backgroundColor), StrokeStyle(color: backgroundColor), backgroundRectangle)
        }
        if !isBackgroundPlaying && background.isReady {
            canvas.render(background)
            isBackgroundPlaying = true
        }
    }
    
}
