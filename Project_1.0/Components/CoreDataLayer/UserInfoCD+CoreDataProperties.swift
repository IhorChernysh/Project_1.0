//
//  UserInfoCD+CoreDataProperties.swift
//  Project_1.0
//
//  Created by Игорь Черныш on 07.12.2020.
//
//

import Foundation
import CoreData


extension UserInfoCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserInfoCD> {
        return NSFetchRequest<UserInfoCD>(entityName: "UserInfoCD")
    }

    @NSManaged public var website: String?
    @NSManaged public var name: String?
    @NSManaged public var username: String?
    @NSManaged public var phone: String?
    @NSManaged public var email: String?
    @NSManaged public var id: Int32
    @NSManaged public var address: UserAddressCD?
    @NSManaged public var company: UserCompanyCD?

}
