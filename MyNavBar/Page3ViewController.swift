//
//  Page3ViewController.swift
//  MyNavBar
//
//  Created by Jakkawad Chaiplee on 2/15/2559 BE.
//  Copyright © 2559 Jakkawad Chaiplee. All rights reserved.
//

import UIKit
import MapleBacon
import Alamofire // connect to server
import SWXMLHash //
import XCDYouTubeKit

class Page3ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    //DataSource -> call back , render
    
    var mDataArray:[XMLIndexer] = []
    var liveBlur:DKLiveBlurView!
    var mRefreshControl:UIRefreshControl!
    @IBOutlet weak var mTableView:UITableView!
    
    override func viewWillAppear(animated: Bool) {
        self.liveBlur.scrollView = self.mTableView
        print("Page3 - viewWillAppear")
    }
    
    override func viewDidAppear(animated: Bool) {
        print("Page3 - viewDidAppear")
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        self.liveBlur.scrollView = nil
        print("Page3 - viewWillDisappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        print("Page3 - viewDidDisappear")
    }
    
    func feedData() {
        print("loading...")
        let params = ["type":"xml"]
        Alamofire.request(.POST, "http://codemobiles.com/adhoc/feed/youtube_feed.php", parameters: params, encoding: .URL, headers: nil).responseString {
            (request, response, result) -> Void in
            //print(result.value!)
            let xml = SWXMLHash.parse(result.value!)
            
            self.mDataArray = xml["youtubes_list"].children
            //print(self.mDataArray.description)
            self.mTableView.reloadData()
            self.mRefreshControl.endRefreshing()
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let item:XMLIndexer = self.mDataArray[indexPath.row]
        let youtubeID = item["youtubeID"].element?.text!
        let vc = XCDYouTubeVideoPlayerViewController(videoIdentifier: youtubeID)
        self.presentViewController(vc, animated: true, completion: nil)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    /*
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let item:XMLIndexer = self.mDataArray[indexPath.row]
    let youtubeID = item["youtubeID"].element?.text!
    let playerVC = XCDYouTubeVideoPlayerViewController(videoIdentifier: youtubeID)
    self.presentViewController(playerVC, animated: true, completion: nil)
    
    }
    */
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return 100
        return self.mDataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // as = upcast จากลูกไปแม่
        // as? = downcast - optional
        // as! = downcase = forced
        let cell = tableView.dequeueReusableCellWithIdentifier("lek") as? CustomTableViewCell
        //cell?.mTitleLabel.text = "CodeMobiles"
        
        let item = self.mDataArray[indexPath.row]
        
        cell?.mTitleLabel.text = item["title"].element?.text
        cell?.mSubtitileLabel.text = item["description"].element?.text
        let avatarImageString = item["image_link"].element!.text!
        let thumbnailImageString = item["youtube_image"].element!.text!
        
        let thumbnailUrl = NSURL(string: thumbnailImageString)!
        cell?.mThumbnailImage.setImageWithURL(thumbnailUrl)
        
        let avatarUrl = NSURL(string: avatarImageString)!
        cell?.mAvatarImage.setImageWithURL(avatarUrl)
        return cell!
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.feedData()
        
        //add headerView
        let headerView = UIView()
        headerView.frame = CGRectMake(0, 0, 1, 270)
        self.mTableView.tableHeaderView = headerView
        
        //set blur image
        self.liveBlur = DKLiveBlurView(frame: self.view.bounds)
        self.liveBlur.originalImage = UIImage(named: "listview_iphone.png")
        self.mTableView.backgroundView = self.liveBlur
        
        //add refresh control
        self.mRefreshControl = UIRefreshControl()
        self.mRefreshControl.addTarget(self, action: Selector("feedData"), forControlEvents: .ValueChanged)
        self.mTableView.addSubview(self.mRefreshControl)
        
        
        //self.mTableView.delegate = self
        
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
