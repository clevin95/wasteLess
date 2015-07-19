//
//  PostManager.swift
//  WasteLess
//
//  Created by Carter Levin on 18/07/15.
//  Copyright (c) 2015 Carter Levin. All rights reserved.
//

import UIKit

class PostManager: NSObject {
  var allPosts:[Posting] = [] {
    didSet {
      NSNotificationCenter.defaultCenter().postNotificationName("addedPost", object: nil, userInfo: nil)
    }
  }
  
  class var sharedInstance : PostManager {
    struct Static {
      static let instance : PostManager = PostManager()
    }
    return Static.instance
  }
  
  class func postPosting (newPosting:Posting) {
    let testURL = "http://wasteless.herokuapp.com/api/v1/postings/create"
    let url = NSURL(string: testURL)
    var session:NSURLSession = NSURLSession.sharedSession()
    var request:NSMutableURLRequest = NSMutableURLRequest()
    var bodyDic:[String:AnyObject] = [:]
    bodyDic["name"] = newPosting.name
    bodyDic["description"] = newPosting.productDescription
    bodyDic["amount"] = newPosting.amount
    

    bodyDic["latitude"] = newPosting.latitude
    bodyDic["longitude"] = newPosting.longitude
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("VXLDyOUTEtciprGYKiEGfQtt" , forHTTPHeaderField: "X-Api-Key")
    request.URL = url
    var error:NSError?
    request.HTTPMethod = "POST"
    request.HTTPBody = NSJSONSerialization.dataWithJSONObject(bodyDic, options: nil, error: &error)
    let task = session.dataTaskWithRequest(request, completionHandler: {(data,response,error) in
      print(response)
      print(error)
      
    })
    task.resume()
  }
  
  class func getPosts (arrayPassback:(([Posting]) -> Void)){
    let testURL = "http://wasteless.herokuapp.com/api/v1/postings/all"
    let url = NSURL(string: testURL)
    var session:NSURLSession = NSURLSession.sharedSession()
    var request:NSMutableURLRequest = NSMutableURLRequest()
    request.URL = url
    var error:NSError?
    request.HTTPMethod = "GET"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("VXLDyOUTEtciprGYKiEGfQtt" , forHTTPHeaderField: "X-Api-Key")
    let task = session.dataTaskWithRequest(request, completionHandler: {(data,response,error) in
      if let output:NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options:nil, error: nil) as? NSDictionary {
        let array:NSArray = output["data"] as! NSArray
        var allPosts:[Posting] = []
        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
          for arrayItem in array {
            
            allPosts.append(self.convertDictionaryToPost(arrayItem as! [String : AnyObject]))
          }
           arrayPassback(allPosts)
          
        })
      }
    })
    task.resume()
  }
  
  class func convertDictionaryToPost(postDic:[String:AnyObject]) -> Posting {
    let inPost = Posting()
    inPost.name = postDic["name"] as? String
    inPost.productDescription = postDic["description"] as? String
    inPost.longitude = postDic["longitude"]! as? Double
    inPost.latitude = postDic["latitude"]! as? Double
    return inPost
//    inPost.productDescription = postDic["description"] as! String
//    inPost.
  }
  
}
