//
//  DrawViewController.swift
//  swag-htn
//
//  Created by Jasvin Baweja on 2017-09-16.
//
//

import FirebaseCore
import FirebaseStorage
import UIKit
import SwiftyDraw

extension UIImage {
    convenience init(view: UIView) {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: (image?.cgImage)!)
    }
}

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
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imagesRef = storageRef.child("images")
        let imageRef = storageRef.child("images/img.jpg")
        
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
        DownloadImageUpdated()
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
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imageRef = storageRef.child("images/img.jpg")
        
        print("Did finish drawing")
        let image = UIImage(view: myView)
        let imageData = UIImageJPEGRepresentation(image, 1.0)
        imageRef.putData(imageData!, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                return
            }
            // Metadata contains file metadata such as size, content-type, and download URL.
            let downloadURL = metadata.downloadURL
        }
        
    }
    
    func DownloadImageUpdated(){
        let pathReference = Storage.storage().reference(withPath: "images/img.jpg")
        pathReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                // Uh-oh, an error occurred!
            } else {
                // Data for "images/island.jpg" is returned
                //UIGraphicsBeginImageContext(self.myView.frame.size)
                let image = UIImage(data: data!)
                //image?.draw(in: myView.bounds)
                //UIGraphicsEndImageContext()
                self.myView.backgroundColor = UIColor(patternImage: image!)
            }
        }
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
