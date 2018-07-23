/*
 * Copyright (c) 2015 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit

let π = CGFloat(Double.pi)

class CanvasView: UIImageView {
    
    // Parameters
    private let defaultLineWidth:CGFloat = 6
    
    private var drawColor: UIColor = UIColor.red
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesMoved")
        
        
        guard let touch = touches.first else { return }
        
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        
        // Draw previous image into context
        image?.draw(in: bounds)
        
        drawStroke(context: context, touch: touch)
        
        // Update image
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    
    
    private func drawStroke(context: CGContext?, touch: UITouch) {
        let previousLocation = touch.previousLocation(in: self)
        let location = touch.location(in: self)
        
        print("drawstroke")
        // Calculate line width for drawing stroke
        let lineWidth = lineWidthForDrawing(context: context, touch: touch)
        
        // Set color
        drawColor.setStroke()
        
        // Configure line
        context?.setLineWidth(lineWidth)
        context?.setLineCap(.round)
        //CGContextSetLineWidth(context!, lineWidth)
        //CGContextSetLineCap(context!, .Round)
        
        
        // Set up the points
        context?.move(to: previousLocation)
        //CGContextMoveToPoint(context, previousLocation.x, previousLocation.y)
        context?.addLine(to: location)
        //CGContextAddLineToPoint(context, location.x, location.y)
        
        // Draw the stroke
        context?.strokePath()
        //CGContextStrokePath(context)
        
    }
    
    private func lineWidthForDrawing(context: CGContext?, touch: UITouch) -> CGFloat {
        
        let lineWidth = defaultLineWidth
        
        return lineWidth
    }
    
    func clearCanvas(animated: Bool) {
        print("clear canvas")
        if animated {
            UIView.animate(withDuration: 0.5, animations: {
                self.alpha = 0
            }, completion: { finished in
                self.alpha = 1
                self.image = nil
            })
        } else {
            image = nil
        }
    }
}
