//
//  Page4ViewController.swift
//  MyNavBar
//
//  Created by Jakkawad Chaiplee on 2/15/2559 BE.
//  Copyright © 2559 Jakkawad Chaiplee. All rights reserved.
//

import UIKit
import MapleBacon
import Alamofire // connect to server
import XCDYouTubeKit



class Page4ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var mTableView:UITableView!
    var mDataArray = NSArray()
    var liveBlur:DKLiveBlurView!
    var mRefreshControl:UIRefreshControl!
    
    override func viewWillAppear(animated: Bool) {
        self.liveBlur.scrollView = self.mTableView
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.liveBlur.scrollView = nil
    }
    
    func feedData() {
        //let params = ["api":"productall","productall":"37"]
        let params = ["type":"json"]
        Alamofire.request(.POST, "http://codemobiles.com/adhoc/feed/youtube_feed.php", parameters: params, encoding: .URL, headers: nil).responseJSON { (request, response, result) -> Void in
        //Alamofire.request(.POST, "https://www.all2sale.com/sendmail/testfunction/json/apitest.php", parameters: params, encoding: .URL, headers: nil).responseJSON { (request, response, result) -> Void in
            //print(result.value)
            self.mDataArray = result.value as! NSArray
            //print(self.mDataArray.description)
            self.mTableView.reloadData()

        }   //print(result.value!)
            
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let item = self.mDataArray[indexPath.row]
        let youtubeID = item.objectForKey("youtubeID") as! String
        let vc = XCDYouTubeVideoPlayerViewController(videoIdentifier: youtubeID)
        self.navigationController?.presentViewController(vc, animated: true, completion: nil)
        
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return 100
        return self.mDataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("lek") as? CustomTableViewCell
        let item = self.mDataArray[indexPath.row] as! NSDictionary
        /*
        cell?.mTitleLabel.text = item.objectForKey("Id") as? String
        cell?.mSubtitileLabel.text = item.objectForKey("ProductBrand") as? String
        
        let avatarUrlString = item.objectForKey("ProductShowImage") as? String
        let thumnailUrlString = item.objectForKey("ProductShowImage") as? String
        */
        
        
        cell?.mTitleLabel.text = item.objectForKey("title") as? String
        cell?.mSubtitileLabel.text = item.objectForKey("description") as? String
        
        let avatarUrlString = item.objectForKey("image_link") as? String
        let thumnailUrlString = item.objectForKey("youtube_image") as? String
        
        //var v1 = "https://www.all2sale.com/store/"
        //v1 += avatarUrlString!
        //print(v1)
        //print("https://www.all2sale.com/store/" += avatarUrlString)
        //var avatarUrlString2 = "https://www.all2sale.com/store/"
        //avatarUrlString2 += avatarUrlString
        
        let avatarUrl = NSURL(string: avatarUrlString!)!
        //let avatarUrl = NSURL(string: v1)!
        let thumnaiUrl = NSURL(string: thumnailUrlString!)!
        
        cell?.mAvatarImage.setImageWithURL(avatarUrl)
        cell?.mThumbnailImage.setImageWithURL(thumnaiUrl)
        
        return cell!
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        feedData()
        //self.mTableView.delegate = self
        
        //add headerView
        let headerView = UIView()
        headerView.frame = CGRectMake(0, 0, 1, 270)
        self.mTableView.tableHeaderView = headerView
        
        //add blur
        self.liveBlur = DKLiveBlurView(frame: self.view.bounds)
        self.liveBlur.originalImage = UIImage(named: "listview_iphone.png")
        self.mTableView.backgroundView = self.liveBlur
        
        //add refresh
        self.mRefreshControl = UIRefreshControl()
        self.mRefreshControl.addTarget(self, action: Selector("feedData"), forControlEvents: .ValueChanged)
        self.mTableView.addSubview(self.mRefreshControl)
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
