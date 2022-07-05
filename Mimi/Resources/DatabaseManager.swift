//
//  DatabaseManager.swift
//  Mimi
//
//  Created by Oluwakemi Onajinrin on 6/7/22.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    //    public func test() {
    //        database.child("foo").setValue(["something" : true])
    //    }
    //
}
// MARK: - Account Management

extension DatabaseManager {
    
    public func doesUserExists(with email: String, completion: @escaping ((Bool) -> Void))  {
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
       
        database.child(safeEmail).observeSingleEvent(of: .value, with: { snapshot in // return a snapsot
            guard snapshot.value as? String != nil else {
                completion(false)
                 return
            }
            completion(true)
        })
    }
    // Inserts new user to database
    public func insertUser(with user: ChatAppUser) {
        database.child(user.safeEmail).setValue(["first_name" : user.firstname,
                                                 "last_name": user.lastname])
        
    }
    
}
    struct ChatAppUser {
        let firstname: String
        let lastname: String
        let emailAddress: String
        //        let profilePictureUrl:String
        var safeEmail: String {
            var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
            safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
            return safeEmail
        }
    }
    
    // child refers to key we want to write data to
