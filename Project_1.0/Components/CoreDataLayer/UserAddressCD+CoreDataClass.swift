//
//  UserAddressCD+CoreDataClass.swift
//  Project_1.0
//
//  Created by Игорь Черныш on 07.12.2020.
//
//

import Foundation
import CoreData

@objc(UserAddressCD)
public class UserAddressCD: NSManagedObject {

    static let entityName = "UserAddressCD"
    
    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    init(with userAddress: UserAddress, entity: NSEntityDescription, insertInto context: NSManagedObjectContext) {
        super.init(entity: entity, insertInto: context)
        self.street = userAddress.street
        self.suite = userAddress.suite
        self.city = userAddress.city
        self.zipcode = userAddress.zipcode
        self.lat = userAddress.geo?.lat
        self.lng = userAddress.geo?.lng
    }
}
