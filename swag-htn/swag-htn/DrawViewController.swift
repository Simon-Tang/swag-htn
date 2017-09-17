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
    
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var opacitySlider: UISlider!
    @IBOutlet weak var thicknessSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //drawView = SwiftyDrawView(frame: myView.frame)
        //drawView = SwiftyDrawView(frame: self.view.frame)
        //drawView.delegate = self
        
        //myView.addSubview(drawView)
        
        //self.view.addSubview(drawView)
        //drawView.lineColor = UIColor.black
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        drawView = SwiftyDrawView(frame: myView.frame)
        drawView.delegate = self
        myView.addSubview(drawView)
        drawView.lineColor = UIColor.black
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func opacitySliderValueDidChange(_ sender: Any) {
        drawView.lineOpacity = CGFloat(opacitySlider.value)
    }
    @IBAction func thicknessSliderValueDidChange(_ sender: Any) {
        drawView.lineWidth = CGFloat(thicknessSlider.value)
    }
    
    
    
    func SwiftyDrawDidBeginDrawing(view: SwiftyDrawView) {
        print("Did begin drawing")
        //UIView.animate(withDuration: 0.5, animations: {
        //    self.opacitySlider.alpha = 0.0
            
        //})
    }
    
    func SwiftyDrawIsDrawing(view: SwiftyDrawView) {
        print("Is Drawing")
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
