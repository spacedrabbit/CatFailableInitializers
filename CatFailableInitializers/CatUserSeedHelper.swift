//
//  UserSeedHelper.swift
//  CatUserDefaults
//
//  Created by Louis Tur on 6/18/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import Foundation

internal class CatUserSeedHelper {
  
  internal class func loadUserSeedData() {
    
    if let path = NSBundle.mainBundle().pathForResource("random_catUsers", ofType: "json") {
      if let jsonData = NSData(contentsOfFile: path) {
        
        do {
          
          if let jsonResults = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableContainers) as? NSDictionary {
            if let results: [[String : AnyObject]] = jsonResults[CatUserKeys.results] as? [[String : AnyObject]] {
              
              for result in results {
                if let newUser: CatUser = CatUser(withJSON: result) {
                  print("User: \(newUser.jsonRepresentation())\n\n")
                }
              }
              
            }
          }
        }
        catch let error as NSError {
          print("Loading JSON data threw: \(error)")
        }
        
        
      }
    }
  }
  
}