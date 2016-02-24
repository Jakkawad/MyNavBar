//
//  Page2ViewController.swift
//  MyNavBar
//
//  Created by Jakkawad Chaiplee on 2/15/2559 BE.
//  Copyright © 2559 Jakkawad Chaiplee. All rights reserved.
//

import UIKit
import Alamofire
import SWXMLHash

class Page2ViewController: UIViewController {

    @IBOutlet weak var mDieselLabel: UILabel!
    @IBOutlet weak var mE85Label: UILabel!
    @IBOutlet weak var mE20Label: UILabel!
    @IBOutlet weak var mS91Label: UILabel!
    @IBOutlet weak var mS95Label: UILabel!
    
    var mDataArray:[XMLIndexer]! //[String], [Int]
    
    @IBAction func onClickRefresh() {
        print("refresh")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callWebservice()
        //self.callWebservice2()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func  callWebservice(){
        let soapMsg = NSLocalizedString("PTT_WS", comment: "PPT Web Req")//key soap
        
        let url:NSURL = NSURL(string: "http://www.pttplc.com/webservice/pttinfo.asmx")!//url
        let wsSoapAction = "http://www.pttplc.com/ptt_webservice/CurrentOilPrice"//action
        
        // create NSURLRequest
        let request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
        let msgLength = String(format: "%tu",soapMsg.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
        request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.addValue(wsSoapAction, forHTTPHeaderField: "SOAPAction")
        request.addValue(msgLength, forHTTPHeaderField: "Content-Length")
        request.HTTPMethod = "POST"
        request.HTTPBody = soapMsg.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        
        Alamofire.request(request).responseString { (request, response, result) -> Void in
            //print(result.value!)
            //print(self.getWellXMLFormat(result.valuse!))
            print(self.parseXML(result.value!))
        }
    }
    
    func callWebservice2() {
        
        // set request parameters
        let tmp = NSLocalizedString("REQ2", comment: "PPT Web Req")
        let soapMsg = String(format: tmp, arguments: ["sunnysunoc@gmail.com"])
        print(tmp)
        
        let url:NSURL = NSURL(string: "http://www.webservicex.net/ValidateEmail.asmx")!
        let wsSoapAction = "http://www.webservicex.net/IsValidEmail"
        
        // create NSURLRequest
        let request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
        let msgLength = String(format: "%tu",soapMsg.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
        request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.addValue(wsSoapAction, forHTTPHeaderField: "SOAPAction")
        request.addValue(msgLength, forHTTPHeaderField: "Content-Length")
        request.HTTPMethod = "POST"
        request.HTTPBody = soapMsg.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        
        Alamofire.request(request).responseString { (request, response, result) -> Void in
            print(result.value!)
            //print(self.getWellXMLFormat(result.valuse!))
            //print(self.parseXML(result.value!))
        }
    }
    
    func parseXML(xmlString:String) {
        let wellXML = self.getWellXMLFormat(xmlString)
        let xml = SWXMLHash.parse(wellXML)
        self.mDataArray = xml["soap:Envelope"]["soap:Body"]["CurrentOilPriceResponse"]["CurrentOilPriceResult"]["PTT_DS"].children
        
        let item:XMLIndexer = self.mDataArray[0]
        let tmp_product = item["PRODUCT"].element?.text
        for item in self.mDataArray {
            let product = item["PRODUCT"].element?.text
            if product == "Blue Diesel" {
                self.mDieselLabel.text = item["PRICE"].element?.text
            }else if product == "Blue Gasohol E20" {
                self.mE20Label.text = item["PRICE"].element?.text
            }else if product == "Blue Gasohol E85" {
                self.mE85Label.text = item["PRICE"].element?.text
            }else if product == "Blue Gasohol 91" {
                self.mS91Label.text = item["PRICE"].element?.text
            }else if product == "Blue Gasohol 95" {
                self.mS95Label.text = item["PRICE"].element?.text
            }
        }
        
        print(tmp_product!)
        
    }
    /*
    * recheck format &gt
    */
    func getWellXMLFormat(xmlString:String)->String{
        return xmlString.stringByReplacingOccurrencesOfString("&lt;", withString: "<")
            .stringByReplacingOccurrencesOfString("&gt;", withString: ">")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
