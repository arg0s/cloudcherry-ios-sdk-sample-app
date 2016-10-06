//
//  CCSplashViewController.swift
//  CCSampleApp
//
//  Created by Vishal Chandran on 22/09/16.
//  Copyright © 2016 Vishal Chandran. All rights reserved.
//

// ******************************************** //
//                                              //
//       Name: CCSplashViewController           //
//                                              //
//    Purpose: Home Page when user opens app    //
//             User can start Survey            //
//                                              //
// ******************************************** //

// Enter your CloudCherry Username and Password

var _USERNAME = "rohith"
var _PASSWORD = "Test@123"

import UIKit


class CCSplashViewController: UIViewController {
    
    
    // MARK: - Variables
    
    
    var isDynamic = true
    
    
    // MARK: - Outlets
    
    
    var tokenToggleSwitch = UISwitch()
    var staticTokenToggleLabel = UILabel()
    var staticTokenTextField = UITextField()
    
    
    // MARK: - View Life Cycle Methods
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        // Hiding Navigation Bar
        
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        
        // Setting View Background
        
        
        let aBackgroundImageView = UIImageView(frame: UIScreen.mainScreen().bounds)
        aBackgroundImageView.image = UIImage(named: "HomeScreenBG")
        
        self.view.insertSubview(aBackgroundImageView, atIndex: 0)
        
        
        // Adding Top White Line
        
        
        let aWhiteLine = UIView(frame: CGRect(x: 50, y: 50, width: self.view.frame.width - 100, height: 1))
        aWhiteLine.backgroundColor = UIColor.whiteColor()
        
        self.view.addSubview(aWhiteLine)
        
        
        // Adding Option Buttons for Static/Dynamic Initalizaiton
        
        
        staticTokenToggleLabel = UILabel(frame: CGRect(x: 20, y: CGRectGetMaxY(aWhiteLine.frame) + 25, width: self.view.frame.width - 40, height: 20))
        staticTokenToggleLabel.font = UIFont.systemFontOfSize(15)
        staticTokenToggleLabel.textColor = UIColor.whiteColor()
        staticTokenToggleLabel.text = "Static Token - OFF"
        
        self.view.addSubview(staticTokenToggleLabel)
        
        
        tokenToggleSwitch = UISwitch(frame: CGRect(x: self.view.frame.width - 70, y: CGRectGetMaxY(aWhiteLine.frame) + 20, width: 50, height: 20))
        tokenToggleSwitch.onTintColor = UIColor(red: 227/255, green: 99/255, blue: 109/255, alpha: 1.0)
        tokenToggleSwitch.addTarget(self, action: #selector(CCSplashViewController.staticTokenSwitchToggled(_:)), forControlEvents: .ValueChanged)
        
        self.view.addSubview(tokenToggleSwitch)
        
        
        
        
        // Adding Button To View To Start Survey
        
        
        let aSurveyButtonXAlign: CGFloat = (self.view.frame.size.width - 200) / 2
        let aSurveyButtonYAlign: CGFloat = (self.view.frame.size.height - 50) / 2
        
        let aSurveyStartButton = UIButton(type: .Custom)
        aSurveyStartButton.frame = CGRect(x: aSurveyButtonXAlign, y: aSurveyButtonYAlign, width: 200, height: 50)
        aSurveyStartButton.layer.borderColor = UIColor.whiteColor().CGColor
        aSurveyStartButton.layer.borderWidth = 1.0
        aSurveyStartButton.layer.cornerRadius = 25
        aSurveyStartButton.setTitle("START SURVEY", forState: .Normal)
        aSurveyStartButton.addTarget(self, action: #selector(CCSplashViewController.surveyStartButtonTapped), forControlEvents: .TouchUpInside)
        
        self.view.addSubview(aSurveyStartButton)
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Touches Method
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    
    // MARK:- Private Methods
    
    
    func surveyStartButtonTapped() {
        
        self.view.endEditing(true)
        
        if (tokenToggleSwitch.on) {
            
            if (staticTokenTextField.text == "") {
                
                let anAlert = UIAlertController(title: "Alert", message: "Please enter a valid Static Token", preferredStyle: .Alert)
                anAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                self.presentViewController(anAlert, animated: true, completion: nil)
                
            } else {
                
                SurveyCC().setStaticToken(staticTokenTextField.text!)
                SurveyCC().showSurveyInController(self)
                
            }
            
        } else {
            
            SurveyCC().setCredentials(_USERNAME, iPassword: _PASSWORD)
            
            let anUnselectedStarImage = UIImage(named: "StarOff")!
            let aSelectedStarImage = UIImage(named: "StarOn")!
            
            var anUnselectedSmileyImages = [UIImage]()
            var aSelectedSmileyImages = [UIImage]()
            
            for anIndex in 1 ..< 6 {
                
                anUnselectedSmileyImages.append(UIImage(named: "Smiley\(anIndex)Off")!)
                aSelectedSmileyImages.append(UIImage(named: "Smiley\(anIndex)On")!)
                
            }
            
            var aPrefillDictionary = Dictionary<String, AnyObject>()
            
            aPrefillDictionary = ["prefillEmail" : "abc@gmail.com", "prefillMobile" : "9900990000"]
            
            SurveyCC().setCustomSmileyRatingAssets(anUnselectedSmileyImages, iSmileySelectedAssets: aSelectedSmileyImages)
            SurveyCC().setCustomStarRatingAssets(anUnselectedStarImage, iStarSelectedAsset: aSelectedStarImage)
            SurveyCC().setPrefill(aPrefillDictionary)
            SurveyCC().setCustomTextStyle(.CC_RECTANGLE)
            SurveyCC().showSurveyInController(self)
            
        }
        
    }
    
    
    func staticTokenSwitchToggled(iSwitch: UISwitch) {
        
        if (iSwitch.on) {
            
            staticTokenToggleLabel.text = "Static Token - ON"
            
            staticTokenTextField = UITextField(frame: CGRect(x: 20, y: CGRectGetMaxY(staticTokenToggleLabel.frame) + 15, width: self.view.frame.width - 40, height: 20))
            staticTokenTextField.attributedPlaceholder = NSAttributedString(string:"Enter Static Token",
                                                                             attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
            staticTokenTextField.textColor = UIColor.whiteColor()
            
            let aBottomBorder = CALayer()
            let aWidth = CGFloat(1.0)
            aBottomBorder.borderColor = UIColor.whiteColor().CGColor
            aBottomBorder.frame = CGRect(x: 0, y: staticTokenTextField.frame.size.height - aWidth, width: staticTokenTextField.frame.size.width, height: staticTokenTextField.frame.size.height)
            
            aBottomBorder.borderWidth = aWidth
            staticTokenTextField.layer.addSublayer(aBottomBorder)
            staticTokenTextField.layer.masksToBounds = true
            
            self.view.addSubview(staticTokenTextField)
            
        } else {
            
            staticTokenToggleLabel.text = "Static Token - OFF"
            
            staticTokenTextField.removeFromSuperview()
            
        }
        
    }

}

