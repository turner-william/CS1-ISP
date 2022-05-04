import Scenes
import Igis

/*
 This class is responsible for rendering the background.
 */


class Background : RenderableEntity {

    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Background")
    }
    override func render(canvas: Canvas){
        if let canvasSize = canvas.canvasSize{
            let backgroundRect = Rect(topLeft: Point(x:0, y:0), size: Size(width:canvasSize.width, height:canvasSize.height))
            let backgroundRectangle = Rectangle(rect:backgroundRect, fillMode: .fillAndStroke)
            let backgroundColor = Color(.green)
            canvas.render(FillStyle(color: backgroundColor), StrokeStyle(color: backgroundColor), backgroundRectangle)
        }
    }
}
