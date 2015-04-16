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
    var isInLoad = false
    @IBAction func getGacha(sender: AnyObject) {
        if (self.isInLoad == false){
            self.isInLoad = true
            self.myLabel.text = "????"

            // create the url-request
            let urlString = "http://httpbin.org/get"

            var request = NSMutableURLRequest(URL: NSURL(string: urlString)!)
            
            // set the method(HTTP-GET)
            request.HTTPMethod = "GET"
            
            // use NSURLSession
            var session = NSURLSession.sharedSession()
            var task = session.dataTaskWithRequest(request) {
                (data, response, error) -> Void in
                if (error == nil) {
                    var dict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                    self.myLabel.text = dict["url"] as NSString
                    self.isInLoad = false
                    println(self.isInLoad)
                    println(self.myLabel.text)
                } else {
                    self.myLabel.text = "error"
                }
            }
            task.resume()
        } else {
            self.myLabel.text = "wait!"
        }
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

