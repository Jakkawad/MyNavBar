//
//  Page1ViewController.swift
//  MyNavBar
//
//  Created by Jakkawad Chaiplee on 2/15/2559 BE.
//  Copyright © 2559 Jakkawad Chaiplee. All rights reserved.
//

import UIKit

class Page1ViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var mWebView:UIWebView!
    @IBOutlet weak var mActivityIndicarot:UIActivityIndicatorView!
    
    @IBAction func onValueChangedSegment(sender:AnyObject) {
        switch sender.selectedSegmentIndex {
        case 0 :
            self.openWeb()
            break
        default:
            self.openPDF()
            break
        }
    }
    
    func openWeb() {
        print("openWeb")
        let url = NSURL(string: "http://all2sale.com/") // step1
        let req = NSURLRequest(URL: url!) // step2
        self.mWebView.loadRequest(req) // step3
    }
    
    func openPDF() {
        print("openPDF")
        let pdfPath = NSBundle.mainBundle().pathForResource("product", ofType: "pdf")
        let pdfData = NSData(contentsOfFile: pdfPath!)
        self.mWebView.loadData(pdfData!, MIMEType: "application/pdf", textEncodingName: "utf-8", baseURL: NSURL())

        print(pdfPath!)
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        self.mActivityIndicarot.startAnimating()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        self.mActivityIndicarot.stopAnimating()
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if request.URL?.absoluteString == "http://www.codemobiles.com/biz/contact.html" {
            self.navigationController?.popViewControllerAnimated(true)
        }//URL GET
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.openWeb()
        //self.mWebView.delegate = self
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
