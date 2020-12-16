//
//  UserAddressCD+CoreDataProperties.swift
//  Project_1.0
//
//  Created by Игорь Черныш on 07.12.2020.
//
//

import Foundation
import CoreData


extension UserAddressCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserAddressCD> {
        return NSFetchRequest<UserAddressCD>(entityName: entityName)
    }

    @NSManaged public var street: String?
    @NSManaged public var suite: String?
    @NSManaged public var city: String?
    @NSManaged public var zipcode: String?
    @NSManaged public var lat: String?
    @NSManaged public var lng: String?
    @NSManaged public var address: UserInfoCD?

}
