//
//  ListViewController.swift
//  WasteLess
//
//  Created by Carter Levin on 18/07/15.
//  Copyright (c) 2015 Carter Levin. All rights reserved.
//

import UIKit


class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  lazy var postingsTable:UITableView = {
    let table = UITableView()
    table.registerClass(PostInfoTableViewCell.self, forCellReuseIdentifier: "postingCell")
    return table
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    postingsTable.delegate = self
    postingsTable.dataSource = self
    self.view.addSubview(postingsTable)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "addedPost", name: "addedPost", object: nil)
  }
  
  override func viewWillLayoutSubviews() {

  }
  
  override func viewWillAppear(animated: Bool) {
    let navHeight:CGFloat = self.navigationController!.navigationBar.frame.size.height + 20
    self.postingsTable.frame = CGRectMake(0.0, navHeight, self.view.frame.width, self.view.frame.height)
    self.postingsTable.contentOffset = CGPointMake(0.0, navHeight)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func addedPost() {
    NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
      self.postingsTable.reloadData() 
    }
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return PostManager.sharedInstance.allPosts.count
  }
  
  func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("postingCell") as! UITableViewCell
    cell.textLabel?.text = PostManager.sharedInstance.allPosts[indexPath.row].name
    cell.detailTextLabel!.text = PostManager.sharedInstance.allPosts[indexPath.row].productDescription
    return cell
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 50
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
