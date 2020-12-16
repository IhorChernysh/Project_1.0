//
//  UserCommentsCD+CoreDataClass.swift
//  Project_1.0
//
//  Created by Игорь Черныш on 07.12.2020.
//
//

import Foundation
import CoreData

@objc(UserCommentsCD)
public class UserCommentsCD: NSManagedObject {

    static let entityName = "UserCommentsCD"
    
    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    init(with userComments: UserComments, entity: NSEntityDescription, insertInto context: NSManagedObjectContext) {
        super.init(entity: entity, insertInto: context)
        self.postId = Int32(userComments.postId ?? 0)
        self.id = Int32(userComments.id ?? 0)
        self.name = userComments.name
        self.email = userComments.email
        self.body = userComments.body
    }
}
