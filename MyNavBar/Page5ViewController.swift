//
//  Page5ViewController.swift
//  MyNavBar
//
//  Created by Jakkawad Chaiplee on 2/15/2559 BE.
//  Copyright © 2559 Jakkawad Chaiplee. All rights reserved.
//

import UIKit
import APAvatarImageView
import Alamofire

class Page5ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView:APAvatarImageView!
    var imgPicker:UIImagePickerController!
    var request:NSMutableURLRequest!
    var fileURL:NSURL!
    
    @IBAction func onClickOpenCamera() {
        print("onClickOpenCamera")
        self.navigationController?.presentViewController(self.imgPicker, animated: true, completion: nil)
    }
    
    @IBAction func onClickUploadImage() {
        print("onClickUploadImage")
        let imageData = UIImageJPEGRepresentation(self.imageView.image!, 0.5)//resize 1.0 and 0.5
        let name = "\(arc4random()).jpg"
        self.uploadFileUtil("http://192.168.0.121/uploads/up.php", data: imageData!, fileName: name)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.imageView.image = image
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func uploadFileUtil(urlString:String, data:NSData, fileName:String){
        
        let TWITTERFON_FORM_BOUNDARY:String = "AaB03x"
        let url = NSURL(string: urlString)!
        let request:NSMutableURLRequest = NSMutableURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 10)
        let MPboundary:String = "--\(TWITTERFON_FORM_BOUNDARY)"
        let endMPboundary:String = "\(MPboundary)--"
        let body:NSMutableString = NSMutableString();
        
        // image upload
        body.appendFormat("%@\r\n",MPboundary)
        body.appendFormat("Content-Disposition: form-data; name=\"userfile\"; filename=\"\(fileName)\"\r\n")
        body.appendFormat("Content-Type: image/png\r\n\r\n")
        let end:String = "\r\n\(endMPboundary)"
        let myRequestData:NSMutableData = NSMutableData();
        myRequestData.appendData(body.dataUsingEncoding(NSUTF8StringEncoding)!)
        myRequestData.appendData(data)
        myRequestData.appendData(end.dataUsingEncoding(NSUTF8StringEncoding)!)
        let content:String = "multipart/form-data; boundary=\(TWITTERFON_FORM_BOUNDARY)"
        request.setValue(content, forHTTPHeaderField: "Content-Type")
        request.setValue("\(myRequestData.length)", forHTTPHeaderField: "Content-Length")
        request.HTTPMethod = "POST"
        
        Alamofire.upload(request, data: myRequestData).responseString { (request, response, result) -> Void in
            self.showDialog(result.value!)
        }
        
    }
    
    func showDialog(responseMsg:String){
        let alert = UIAlertController(title: "Successfully", message: responseMsg, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "CLOSE", style: UIAlertActionStyle.Default, handler: nil))
        
        alert.addAction(UIAlertAction(title: "DONE", style: UIAlertActionStyle.Default, handler: { (alert) -> Void in
            print("DONE")
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    // func
    func imageWithCorrectOrientation(img:UIImage) -> UIImage {
        if img.imageOrientation == UIImageOrientation.Up {
            return img
        }
        
        UIGraphicsBeginImageContextWithOptions(img.size, false, img.scale)
        img.drawInRect(CGRectMake(0, 0, img.size.width, img.size.height))
        let normalizedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return normalizedImage;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imgPicker = UIImagePickerController()
        self.imgPicker.sourceType = .PhotoLibrary
        self.imgPicker.delegate = self
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
