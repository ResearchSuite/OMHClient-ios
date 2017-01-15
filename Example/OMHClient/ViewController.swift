//
//  ViewController.swift
//  OMHClient
//
//  Created by jdkizer9 on 01/06/2017.
//  Copyright (c) 2017 jdkizer9. All rights reserved.
//

import UIKit
import OMHClient

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let omhClientDetails = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "OMHClient", ofType: "plist")!)
        
        guard let baseURL = omhClientDetails?["OMHBaseURL"] as? String,
            let clientID = omhClientDetails?["OMHClientID"] as? String,
            let clientSecret = omhClientDetails?["OMHClientSecret"] as? String else {
                return
        }
        
        let ohmageClient = OMHClient(baseURL: baseURL,
                  clientID: clientID,
                  clientSecret: clientSecret)
        
        let pam = PAMSample()
        pam.affectArousal = 1
        pam.affectValence = 2
        pam.negativeAffect = 3
        pam.positiveAffect = 4
        pam.mood = "awesome!!"
        
//        let filePath: String = Bundle.main.path(forResource: "consent", ofType: "pdf")!
//        let consentURL:URL = URL(fileURLWithPath: filePath)
//        let consent = ConsentSample(consentURL: consentURL)
        
        let imageFilePath: String = Bundle.main.path(forResource: "a", ofType: "png")!
        let imageURL:URL = URL(fileURLWithPath: imageFilePath)
        let image = ImageSample(imageURL: imageURL)
        
        var decodedPamDictionary: OMHDataPointDictionary!
        let data: Data = NSKeyedArchiver.archivedData(withRootObject: pam.toDict())
        
        let secureUnarchiver = NSKeyedUnarchiver(forReadingWith: data)
        secureUnarchiver.requiresSecureCoding = true
        decodedPamDictionary = secureUnarchiver.decodeObject(of: [NSDictionary.self], forKey: NSKeyedArchiveRootObjectKey) as! OMHDataPointDictionary
        debugPrint(decodedPamDictionary)
        
//        do {
//            
//            
//        } catch let error as NSError {
//            print(error.localizedDescription)
//        }
        
        
        
        
        
        
        
        ohmageClient.signIn(username: "SDKTester", password: "password1") { (response, error) in
            
//            debugPrint(error)
//            debugPrint(response)
            
            if let err = error as? NSError {
                debugPrint(err)
//                let domain = e
            }
            
            if let signInResponse = response {
                
                
                ohmageClient.postSample(sampleDict: image.toDict(), mediaAttachments: image.attachments, token: signInResponse.accessToken, completion: { (success, error) in
                    
//                    debugPrint(error)
//                    debugPrint(success)
                    
                    
                })
                
                
                
//                ohmageClient.postSample(sampleDict: decodedPamDictionary, token: signInResponse.accessToken, completion: { (success, error) in
//                    
//                    debugPrint(error)
//                    debugPrint(success)
//                    
//                    ohmageClient.refreshAccessToken(refreshToken: signInResponse.refreshToken, completion: { (response, error) in
//                        debugPrint(error)
//                        debugPrint(response)
//                    })
//                    
//                    
//                })
                
            }
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

