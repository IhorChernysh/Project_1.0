//
//  UserCompanyCD+CoreDataClass.swift
//  Project_1.0
//
//  Created by Игорь Черныш on 07.12.2020.
//
//

import Foundation
import CoreData

@objc(UserCompanyCD)
public class UserCompanyCD: NSManagedObject {

    static let entityName = "UserCompanyCD"
    
    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    init(with userCompany: UserCompany, entity: NSEntityDescription, insertInto context: NSManagedObjectContext) {
        super.init(entity: entity, insertInto: context)
        self.name = userCompany.name
        self.catchPhrase = userCompany.catchPhrase
        self.bs = userCompany.bs
    }
}
