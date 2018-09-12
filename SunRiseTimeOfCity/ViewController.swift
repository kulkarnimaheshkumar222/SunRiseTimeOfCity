//
//  ViewController.swift
//  SunRiseTimeOfCity
//
//  Created by Student016 on 12/09/18.
//  Copyright © 2018 mahesh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityTextField: UITextField!
    
    @IBOutlet weak var sunRiseLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func findSunRiseAction(_ sender: UIButton) {
        
        let urlString = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22\(cityTextField.text!)%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"
        let url = NSURL(string: urlString)! as URL
        
        let sessionConf = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConf)
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            let r = response
            if(r != nil)
            {
              let d=data
                if(d != nil)
                {
                    do{
                        let firstDic:[String:Any] = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:Any]
                       // print(firstDic)
             
                        
                        let queryDic:[String:Any] = firstDic["query"] as! [String:Any]
                        
                        let resultDic:[String:Any] = queryDic["results"] as! [String:Any]
                        
                        let channelDic:[String:Any] = resultDic["channel"] as! [String:Any]
                        let astronomyDic:[String:Any] = channelDic["astronomy"] as! [String:Any]
                        print(astronomyDic)
                        
                        let sunRise:String =
                            astronomyDic["sunrise"] as! String
                        
                        print(sunRise)
                        
                        DispatchQueue.main.async {
                            
                            self.sunRiseLabel.text = "Sunrise Time  is \(String(describing: astronomyDic["sunrise"]!))"
                        }
                        
                        
                        
                        
                        
                        
                        
                        
                        
                    }
                    catch
                    {
                      print(error.localizedDescription)
                    }
                }
                else{
                    print("Data not found:\(String(describing: error?.localizedDescription))")
                }
                
            }
            else{
                print("Response not found:\(String(describing: error?.localizedDescription))")
            }
        }
        
      dataTask.resume()
        
        
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

