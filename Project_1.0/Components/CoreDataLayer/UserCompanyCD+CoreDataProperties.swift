//
//  UserCompanyCD+CoreDataProperties.swift
//  Project_1.0
//
//  Created by Игорь Черныш on 07.12.2020.
//
//

import Foundation
import CoreData


extension UserCompanyCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserCompanyCD> {
        return NSFetchRequest<UserCompanyCD>(entityName: entityName)
    }

    @NSManaged public var name: String?
    @NSManaged public var catchPhrase: String?
    @NSManaged public var bs: String?
    @NSManaged public var company: UserInfoCD?

}
