//
//  NewPostTableViewController.swift
//  WasteLess
//
//  Created by Carter Levin on 18/07/15.
//  Copyright (c) 2015 Carter Levin. All rights reserved.
//

import UIKit

class NewPostTableViewController: UITableViewController, UITextFieldDelegate {
  let fieldValues:[String] = ["name",  "description", "amount", "description", "expiration date"]
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.registerClass(FieldTableViewCell.self, forCellReuseIdentifier: "fieldCell")
    self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "postCell")
    
      // Uncomment the following line to preserve selection between presentations
      // self.clearsSelectionOnViewWillAppear = false

      // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
      // self.navigationItem.rightBarButtonItem = self.editButtonItem()
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }

  
  override func viewWillAppear(animated: Bool) {
    
  }
  // MARK: - Table view data source

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return fieldValues.count + 1
  }


  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    if indexPath.row < fieldValues.count {
      let fieldCell = tableView.dequeueReusableCellWithIdentifier("fieldCell", forIndexPath: indexPath) as! FieldTableViewCell
      fieldCell.textField.placeholder = fieldValues[indexPath.row]
      fieldCell.textField.delegate = self
      return fieldCell
    } else {
      let doneCell = tableView.dequeueReusableCellWithIdentifier("postCell", forIndexPath: indexPath) as! UITableViewCell
      for sub in doneCell.contentView.subviews {
        sub.removeFromSuperview()
      }

      let doneButton:UIButton = UIButton(frame: doneCell.bounds)
      doneButton.backgroundColor = UIColor.redColor()
      doneButton.setTitle("Done", forState: UIControlState.Normal)
      doneButton.addTarget(self, action: "tappedDone", forControlEvents: UIControlEvents.TouchUpInside)
      doneCell.contentView.addSubview(doneButton)
      return doneCell
    }
  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    let parentCell = textField.superview as! UITableViewCell
    let currentIndexPath = tableView.indexPathForCell(parentCell)
    if currentIndexPath!.row + 1 < fieldValues.count {
      let nextIndexPath = NSIndexPath(forRow: currentIndexPath!.row + 1, inSection: 0)
      let nextField = (tableView.cellForRowAtIndexPath(nextIndexPath) as! FieldTableViewCell).textField
      nextField.becomeFirstResponder()
    }
    return true
  }
  
  func getValueForField(field:String) -> String {
    for i in 0...(fieldValues.count - 1) {
      if self.fieldValues[i] == field {
        let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: i, inSection: 0)) as! FieldTableViewCell
        let fieldValue = cell.textField.text
        return fieldValue!
      }
    }
    return ""
  }
  
  
  func tappedDone() {
    let newPost = Posting()
    newPost.name = getValueForField("name")
    newPost.amount = getValueForField("amount")
    newPost.productDescription = getValueForField("description")
    let globalController = self.parentViewController as! GlobalViewController
    newPost.latitude = globalController.mapViewController.currentLocation!.latitude
    newPost.longitude = globalController.mapViewController.currentLocation!.longitude
    PostManager.postPosting(newPost)
    PostManager.sharedInstance.allPosts.append(newPost)
    self.view.endEditing(true)
    self.view.superview!.sendSubviewToBack(self.view)

  }
  

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
}
