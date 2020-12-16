//
//  UserCommentsCD+CoreDataProperties.swift
//  Project_1.0
//
//  Created by Игорь Черныш on 07.12.2020.
//
//

import Foundation
import CoreData


extension UserCommentsCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserCommentsCD> {
        return NSFetchRequest<UserCommentsCD>(entityName: entityName)
    }

    @NSManaged public var body: String?
    @NSManaged public var email: String?
    @NSManaged public var name: String?
    @NSManaged public var id: Int32
    @NSManaged public var postId: Int32

}
