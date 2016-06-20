//
//  CatUser.swift
//  CatFailableInitializers
//
//  Created by Louis Tur on 6/20/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import Foundation

internal struct CatUserKeys {
  internal static let results: String = "results"
  
  internal static let userID: String = "id"
  internal static let firstName: String = "first"
  internal static let lastName: String = "last"
  internal static let email: String = "email"
  internal static let username: String = "username"
  internal static let profileImage: String = "picture"
}

extension CatUser: Equatable {}
func ==(lhs: CatUser, rhs: CatUser) -> Bool {
  return lhs.userId == rhs.userId
}

internal class CatUser {
  
  internal private (set) var userId: String
  internal private (set) var firstName: String
  internal private (set) var lastName: String
  internal private (set) var username: String
  internal private (set) var email: String
  internal private (set) var profileImage: String = "defaultImage.jpg"
  
  private init() {
    userId = ""
    firstName = ""
    lastName = ""
    username = ""
    email = ""
  }
  
  convenience init?(withJSON json: [String : AnyObject]) {
    self.init()
    
    let keys = CatUserKeys.self
    guard let firstNameInfo: String = json[keys.firstName] as? String,
      let lastNameInfo: String = json[keys.lastName] as? String,
      let emailInfo: String = json[keys.email] as? String,
      let usernameInfo: String = json[keys.username] as? String,
      let idInfo: String = json[keys.userID] as? String else {
        keyedErrorHelper(keys.firstName, keys.lastName, keys.email, keys.username, keys.userID)
        return nil // fail our initializer!
    }
    
    self.userId = idInfo
    self.firstName = firstNameInfo
    self.lastName = lastNameInfo
    self.email = emailInfo
    self.username = usernameInfo
    
    guard let pictureInfo: String = json[keys.profileImage] as? String else {
      keyedErrorHelper(keys.profileImage)
      return // no need to fail here, we have a default value
    }
    self.profileImage = pictureInfo
    
  }
  
  internal func jsonRepresentation() -> [String : AnyObject] {
    let key = CatUserKeys.self
    return [
      key.userID : userId,
      key.firstName : firstName,
      key.lastName : lastName,
      key.email : email,
      key.username : username,
      key.profileImage : profileImage,
    ]
  }
  
  
  // MARK: - Helper
  private func keyedErrorHelper(errorKeys: String...) {
    print("Error encountered retrieving \(errorKeys)")
  }
  
}