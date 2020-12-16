//
//  PostInfoCD+CoreDataClass.swift
//  Project_1.0
//
//  Created by Игорь Черныш on 07.12.2020.
//
//

import Foundation
import CoreData

@objc(PostInfoCD)
public class PostInfoCD: NSManagedObject {

    static let entityName = "PostInfoCD"
    
    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    init(with postInfo: PostInfo, entity: NSEntityDescription, insertInto context: NSManagedObjectContext) {
        super.init(entity: entity, insertInto: context)
        self.id = Int32(postInfo.id ?? 0)
        self.userId = Int32(postInfo.userId ?? 0)
        self.title = postInfo.title
        self.body = postInfo.body
    }
}
