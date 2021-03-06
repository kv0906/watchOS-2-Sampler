//
//  DrawPathsInterfaceController.swift
//  watchOS2Sampler
//
//  Created by Shuichi Tsutsumi on 2015/07/14.
//  Copyright © 2015 Shuichi Tsutsumi. All rights reserved.
//

import WatchKit
import Foundation


class DrawPathsInterfaceController: WKInterfaceController {
    
    
    @IBOutlet weak var image: WKInterfaceImage!
    
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
    }

    override func willActivate() {
        super.willActivate()
    }

    override func didDeactivate() {
        super.didDeactivate()
    }
    
    // =========================================================================
    // MARK: - Actions
    
    @IBAction func strokeBtnTapped() {
        
        // Create a graphics context
        let size = CGSizeMake(100, 100)
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        
        // Setup for the path appearance
        CGContextSetStrokeColorWithColor(context, UIColor.whiteColor().CGColor)
        CGContextSetLineWidth(context, 4.0)

        // Draw lines
        CGContextBeginPath (context);
        CGContextMoveToPoint(context, 0, 0);
        CGContextAddLineToPoint(context, 100, 100);
        CGContextMoveToPoint(context, 0, 100);
        CGContextAddLineToPoint(context, 100, 0);
        CGContextStrokePath(context);
        
        // Convert to UIImage
        let cgimage = CGBitmapContextCreateImage(context);
        let uiimage = UIImage(CGImage: cgimage!)

        // End the graphics context
        UIGraphicsEndImageContext()
        
        image.setImage(uiimage)
    }

    @IBAction func bezierBtnTapped() {

        // Create a graphics context
        let size = CGSizeMake(100, 100)
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        
        // Setup for the path appearance
        UIColor.greenColor().setStroke()
        UIColor.whiteColor().setFill()
        
        // Draw an oval
        let rect = CGRectMake(2, 2, 96, 96)
        let path = UIBezierPath(ovalInRect: rect)
        path.lineWidth = 4.0
        path.fill()
        path.stroke()
        
        // Convert to UIImage
        let cgimage = CGBitmapContextCreateImage(context);
        let uiimage = UIImage(CGImage: cgimage!)
        
        // End the graphics context
        UIGraphicsEndImageContext()
        
        image.setImage(uiimage)
    }
    
    @IBAction func svgBtnTapped() {

        // Create a graphics context
        let size = CGSizeMake(512, 512)
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        
        // Setup for the path appearance
        UIColor.yellowColor().setFill()

        // Convert SVG -> CGPath -> UIBezierPath
        let pocketSvg = PocketSVG(fromSVGFileNamed: "sample")
        let path = pocketSvg.bezier
        print(path)
        path.fill()
        
        // Convert to UIImage
        let cgimage = CGBitmapContextCreateImage(context);
        let uiimage = UIImage(CGImage: cgimage!)
        
        // End the graphics context
        UIGraphicsEndImageContext()
        
        image.setImage(uiimage)
    }
}
