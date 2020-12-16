//
//  UserInfoCD+CoreDataClass.swift
//  Project_1.0
//
//  Created by Игорь Черныш on 07.12.2020.
//
//

import Foundation
import CoreData

@objc(UserInfoCD)
public class UserInfoCD: NSManagedObject {

    static let entityName = "UserInfoCD"
    
    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    init(with userInfo: UserInfo, entity: NSEntityDescription, insertInto context: NSManagedObjectContext) {
        super.init(entity: entity, insertInto: context)
        self.id = Int32(userInfo.id ?? 0)
        self.name = userInfo.name
        self.username = userInfo.username
        self.email = userInfo.email
        
        if let userAddress = userInfo.address {
            if let entityDescription = NSEntityDescription.entity(forEntityName: UserAddressCD.entityName, in: context) {
                self.address = UserAddressCD(with: userAddress, entity: entityDescription, insertInto: context)
            }
        }
        
        self.phone = userInfo.phone
        self.website = userInfo.website
        
        if let userCompany = userInfo.company {
            if let entityDescription = NSEntityDescription.entity(forEntityName: UserCompanyCD.entityName, in: context) {
                self.company = UserCompanyCD(with: userCompany, entity: entityDescription, insertInto: context)
            }
        }
    }
}
