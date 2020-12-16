//
//  PostInfoCD+CoreDataProperties.swift
//  Project_1.0
//
//  Created by Игорь Черныш on 07.12.2020.
//
//

import Foundation
import CoreData


extension PostInfoCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PostInfoCD> {
        return NSFetchRequest<PostInfoCD>(entityName: entityName)
    }

    @NSManaged public var id: Int32
    @NSManaged public var userId: Int32
    @NSManaged public var title: String?
    @NSManaged public var body: String?

}
