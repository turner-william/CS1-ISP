import Igis
import Foundation
import Scenes

class Enemy: RenderableEntity{
    var image : Image
    var imageTopLeft = Point(x:0, y:0)
    
    init(){
        guard let imageURL = URL(string:"") else{
            fatalError("failed to create URL for enemy image")
        }
        super.init(name:"Enemy")
    }
    override func render(canvas: Canvas){
        canvas.render
    }
}
