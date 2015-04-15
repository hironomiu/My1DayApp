//
//  ViewController.swift
//  My1DayApp
//
//  Created by 三浦裕典 on 2015/04/15.
//  Copyright (c) 2015年 三浦裕典. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myLabel: UILabel!
    
    @IBAction func getGacha(sender: AnyObject) {
        let results = [
            "大吉",
            "中吉",
            "吉",
            "凶",
            "大凶"
        ]
        
        let random = arc4random_uniform(UInt32(results.count))
        
        if random == 0 {
            self.myLabel.textColor = UIColor.redColor()
        } else {
            self.myLabel.textColor = UIColor.blackColor()
        }
        
        // create the url-request
        //let urlString = "http://api.local/work/api/index.php"
        let urlString = "http://httpbin.org/get"
        var request = NSMutableURLRequest(URL: NSURL(string: urlString)!)
        
        // set the method(HTTP-GET)
        request.HTTPMethod = "GET"
        
        // use NSURLSession
        var task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { data, response, error in
            if (error == nil) {
                var result = NSString(data: data, encoding: NSUTF8StringEncoding)!
                
                var dict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                println(dict["url"] as NSString)
                
            } else {
                println(error)
            }
        })
        task.resume()
        
        self.myLabel.text = results[Int(random)]
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

