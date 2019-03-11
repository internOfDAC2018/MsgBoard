import Foundation
class CGView:UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        let drawingRect = self.bounds.insetBy(dx: 1, dy: 1)
        let path = CGMutablePath()
        print(drawingRect.minX,"   ",drawingRect.minY,"    ",drawingRect.maxY,"      ",drawingRect.maxY)
        path.move(to: CGPoint(x:drawingRect.minX, y:drawingRect.minY))
        path.addLine(to:CGPoint(x:drawingRect.maxX, y:drawingRect.minY))
        context.addPath(path)
        context.setStrokeColor(UIColor.gray.cgColor)
        context.setLineWidth(0.5)
        context.strokePath()
    }
}

