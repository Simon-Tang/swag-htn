//
//  DrawViewController.swift
//  swag-htn
//
//  Created by Jasvin Baweja on 2017-09-16.
//
//

import UIKit
import SwiftyDraw

class DrawViewController: UIViewController, SwiftyDrawViewDelegate {
    
    var drawView : SwiftyDrawView!
    
    @IBOutlet weak var penButton: UIButton!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var opacitySlider: UISlider!
    @IBOutlet weak var thicknessSlider: UISlider!
    @IBOutlet weak var inkProgress: UIProgressView!
    
    @IBOutlet weak var blackButton: UIButton!
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var cyanButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var magentaButton: UIButton!
    @IBOutlet weak var whiteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        penButton.setBackgroundImage(UIImage(named: "fountain-pen-close-up (2).png"), for: UIControlState.normal)
        //drawView = SwiftyDrawView(frame: myView.frame)
        //drawView = SwiftyDrawView(frame: self.view.frame)
        //drawView.delegate = self
        
        //myView.addSubview(drawView)
        
        //self.view.addSubview(drawView)
        //drawView.lineColor = UIColor.black
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        drawView = SwiftyDrawView(frame: myView.bounds)
        drawView.delegate = self
        myView.addSubview(drawView)
        //drawView.lineColor = UIColor.black
        drawView.lineWidth = CGFloat(6)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func  onTouchBlackColor(_ sender: Any) {
        handleColorChange(color: UIColor.black)
    }
    @IBAction func onTouchRedColor(_ sender: Any) {
        handleColorChange(color: UIColor.red)
    }
    @IBAction func onTouchYellowColor(_ sender: Any) {
        handleColorChange(color: UIColor.yellow)
    }
    @IBAction func onTouchGreenColor(_ sender: Any) {
        handleColorChange(color: UIColor.green)
    }
    @IBAction func onTouchCyanColor(_ sender: Any) {
        handleColorChange(color: UIColor.cyan)
    }
    @IBAction func onTouchBlueColor(_ sender: Any) {
        handleColorChange(color: UIColor.blue)
    }
    @IBAction func onTouchMagentaColor(_ sender: Any) {
        handleColorChange(color: UIColor.magenta)
    }
    @IBAction func onTouchWhiteColor(_ sender: Any) {
        handleColorChange(color: UIColor.white)
    }
    
    func handleColorChange(color: UIColor){
        drawView.lineColor = color
    }
    
    @IBAction func opacitySliderValueDidChange(_ sender: Any) {
        drawView.lineOpacity = CGFloat(opacitySlider.value)
    }
    @IBAction func thicknessSliderValueDidChange(_ sender: Any) {
        drawView.lineWidth = CGFloat(thicknessSlider.value * 10 + 1)
    }
 
    func SwiftyDrawDidBeginDrawing(view: SwiftyDrawView) {
        print("Did begin drawing")
        //UIView.animate(withDuration: 0.5, animations: {
        //    self.opacitySlider.alpha = 0.0
            
        //})
    }
    
    func SwiftyDrawIsDrawing(view: SwiftyDrawView) {
        print("Is Drawing")
        var inkX : CGFloat = drawView.currentPoint.x - drawView.previousPoint.x
        if inkX < 0 {
            inkX = inkX * -1.0
        }
        var inkY : CGFloat = drawView.currentPoint.y - drawView.previousPoint.y
        if inkY < 0 {
            inkY = inkY * -1.0
        }
        let ink : CGFloat = (inkX + inkY) / (225.0 * (20 - drawView.lineWidth))
        inkProgress.progress = inkProgress.progress - Float(ink)
        if(inkProgress.progress <= 0) {
            drawView.drawingEnabled = false
        }
    }
    
    func SwiftyDrawDidCancelDrawing(view: SwiftyDrawView) {
        print("Did cancel")
    }
    
    func SwiftyDrawDidFinishDrawing(view: SwiftyDrawView) {
        print("Did finish drawing")
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
