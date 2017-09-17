//
//  PaintViewController.swift
//  swag-htn
//
//  Created by Bora Ozarslan on 2017-09-16.
//
//

//
//  DrawArtView.swift
//  DrawSend
//
//  Created by Daniel Brim on 3/21/15.
//  Copyright (c) 2015 Daniel Brim. All rights reserved.
//
import UIKit

class DrawArtView: UIView {
    
    var brush: Brush = Brush()
    
    private var incrementalImage: UIImage?
    private var lineSegments: [DrawProtocol] = [DrawProtocol]()
    private var currentSegment: DrawProtocol?
    private var drawingQueue = DispatchQueue(label: "drawingQueue");
    private var touchesMoved = false
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.backgroundColor = UIColor.clear
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    
    // Cause UIView is stupid and doesn't have a no arg init to override. It calls some
    // superclass's (probs NSObject) no arg constructor, but you can't override it.
    convenience init() {
        self.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        incrementalImage?.draw(in: rect)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first as UITouch? {
            let point = touch.location(in: self)
            
            print("Touches began with point: \(point)")
            drawingQueue.async(execute: { () -> Void in
                self.currentSegment = self.brush
                self.currentSegment?.addPoint(point: point)
                
                self.lineSegments.append(self.currentSegment!)
                
                UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0);
                if let image = self.incrementalImage {
                    image.draw(at: CGPoint.zero)
                } else {
                    let rectpath = UIBezierPath(rect:self.bounds)
                    self.backgroundColor!.setFill()
                    rectpath.fill()
                }
                self.currentSegment?.draw()
                
                self.incrementalImage = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                
                DispatchQueue.main.async(execute: { () -> Void in
                    self.setNeedsDisplay()
                })
            })
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first as UITouch? {
            let point = touch.location(in: self)
            
            print("Moved with \(touches.count) touches")
            
            drawingQueue.async(execute: { () -> Void in
                self.touchesMoved = true
                self.currentSegment?.addPoint(point: point)
                
                UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0);
                if let image = self.incrementalImage {
                    image.draw(at: CGPoint.zero)
                }
                self.currentSegment?.draw()
                
                self.incrementalImage = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                
                DispatchQueue.main.async(execute: { () -> Void in
                    self.setNeedsDisplay()
                })
            })
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first as UITouch? {
            let point = touch.location(in: self)
            
            print("Ended with \(touches.count) touches")
            drawingQueue.async(execute: { () -> Void in
                if self.touchesMoved {
                    self.currentSegment?.finishWithPoint(point: point)
                    
                    UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0);
                    if let image = self.incrementalImage {
                        image.draw(at: CGPoint.zero)
                    }
                    self.currentSegment?.draw()
                    
                    self.incrementalImage = UIGraphicsGetImageFromCurrentImageContext();
                    UIGraphicsEndImageContext();
                    
                    self.touchesMoved = false
                    DispatchQueue.main.async(execute: { () -> Void in
                        self.setNeedsDisplay()
                    })
                }
            })
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.touchesEnded(touches as Set<UITouch>, with: event)
    }
    
    // Controls
    func reset() {
        incrementalImage = nil
        lineSegments.removeAll(keepingCapacity: true)
        self.setNeedsDisplay()
    }
    
    func undo() {
        lineSegments.removeLast()
        self.setNeedsDisplay()
    }
    
    func undo(count: Int) {
        var start = self.lineSegments.count - count
        if start < 0 {
            start = 0
        }
        let range = Range(start..<self.lineSegments.count)
        
        lineSegments.removeSubrange(range)
        self.setNeedsDisplay()
    }
}
