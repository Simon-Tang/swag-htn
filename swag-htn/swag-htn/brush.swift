//
//  brush.swift
//  swag-htn
//
//  Created by Bora Ozarslan on 2017-09-16.
//
//

import UIKit

protocol DrawProtocol {
    func addPoint(point: CGPoint)
    func finishWithPoint(point: CGPoint)
    func draw()
}

/// Brush
/// Subclass this to create custom drawing brushes
public class Brush: NSObject, DrawProtocol {
    
    public var width: CGFloat = 4.0
    public var color: UIColor = UIColor.black
    public var alpha: CGFloat = 1.0
    
    // These variables help implement this specific brush
    private var path: UIBezierPath = UIBezierPath()
    
    private var ctr: Int = 0
    private var previous: CGPoint?
    private var current: CGPoint?
    
    public override init() {
        super.init()
    }
    
    public convenience init(color: UIColor, width: CGFloat, alpha: CGFloat) {
        self.init()
        
        self.color = color
        self.width = width
        self.alpha = alpha
    }
    
    func startWithPoint(point: CGPoint) {
        
    }
    
    func addPoint(point: CGPoint) {
        
        if ctr == 0 {
            previous = point
            current = point
            
            // Why was this here before?
            // let midpoint = midPoint(p1: current!, p2: previous!)
            
            path.move(to: current!)
            path.addLine(to: current!)
            ctr += 1
        } else {
            previous = current
            current = point
            
            let midpoint = midPoint(p1: current!, p2: previous!)
            path.addQuadCurve(to: midpoint, controlPoint: previous!)
            ctr = 1
        }
    }
    
    func finishWithPoint(point: CGPoint) {
        previous = current
        current = point
        
        if previous != nil {
            let midpoint = midPoint(p1: current!, p2: previous!)
            path.addQuadCurve(to: midpoint, controlPoint: previous!)
        } else {
            path.move(to: point)
        }
        
        previous = nil
        current = nil
    }
    
    func draw() {
        let context: CGContext = UIGraphicsGetCurrentContext()!;
        
        context.addPath(path.cgPath);
        context.setLineCap(CGLineCap.round);
        context.setLineWidth(self.width);
        context.setStrokeColor(self.color.cgColor);
        context.setBlendMode(CGBlendMode.normal);
        context.setAlpha(1.0);
        context.strokePath();
    }
    
    ///MARK: Private Helpers
    
    // Find the midpoint
    private func  midPoint(p1: CGPoint, p2: CGPoint) -> CGPoint {
        return CGPoint(x:  (p1.x + p2.x) * 0.5, y: (p1.y + p2.y) * 0.5);
    }
}
