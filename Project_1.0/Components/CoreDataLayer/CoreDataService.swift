//
//  CoreDataService.swift
//  Project_1.0
//
//  Created by Игорь Черныш on 07.12.2020.
//

import Foundation
import CoreData

class CoreDataService {
    
    static let shared = CoreDataService()
    
    private let coreDataStack = CoreDataStack.shared
    
    private init() {}
    
    // MARK: - Methods
    
    func addPostsInfo(_ postsInfo: [PostInfo]) {
        postsInfo.forEach { postInfo in
            if let entityDescription = NSEntityDescription.entity(forEntityName: PostInfoCD.entityName, in: coreDataStack.managedContext) {
                _ = PostInfoCD(with: postInfo, entity: entityDescription, insertInto: coreDataStack.managedContext)
            }
        }
        coreDataStack.saveContext()
    }
    
    func addUsers(_ usersInfo: [UserInfo]) {
        usersInfo.forEach { userInfo in
            if let entityDescription = NSEntityDescription.entity(forEntityName: UserInfoCD.entityName, in: coreDataStack.managedContext) {
                _ = UserInfoCD(with: userInfo, entity: entityDescription, insertInto: coreDataStack.managedContext)
            }
        }
        coreDataStack.saveContext()
    }
    
    func addUserComments(_ userComments: [UserComments]) {
        userComments.forEach { userComment in
            if let entityDescription = NSEntityDescription.entity(forEntityName: UserCommentsCD.entityName, in: coreDataStack.managedContext) {
                _ = UserCommentsCD(with: userComment, entity: entityDescription, insertInto: coreDataStack.managedContext)
            }
        }
        coreDataStack.saveContext()
    }
    
    // MARK: - Check Objects exist
    
    func containPostsInfo() -> Bool {
        let fetchRequest: NSFetchRequest<PostInfoCD> = PostInfoCD.fetchRequest()
        fetchRequest.fetchLimit = 1
        
        var containObjects = false
        do {
            let results = try CoreDataStack.shared.managedContext.fetch(fetchRequest)
            containObjects = !results.isEmpty
        } catch {
            print("Fatal error. Can not fetch objects")
        }
        return containObjects
    }
    
    func containUserInfo() -> Bool {
        let fetchRequest: NSFetchRequest<UserInfoCD> = UserInfoCD.fetchRequest()
        fetchRequest.fetchLimit = 1
        
        var containObjects = false
        do {
            let results = try CoreDataStack.shared.managedContext.fetch(fetchRequest)
            containObjects = !results.isEmpty
        } catch {
            print("Fatal error. Can not fetch objects")
        }
        return containObjects
    }
    
    func fetchUserInfo(userID: Int) -> UserInfoCD? {
        let fetchRequest: NSFetchRequest<UserInfoCD> = UserInfoCD.fetchRequest()
        let customPredicate = NSPredicate(format: "id = %@", String(userID))
        fetchRequest.predicate = customPredicate
        do {
            let results = try CoreDataStack.shared.managedContext.fetch(fetchRequest)
            return results.first
        } catch {
            print("Fatal error. Can not fetch objects")
        }
        return nil
    }
    
    func fetchUserComments(id: Int) -> [UserCommentsCD]? {
        let fetchRequest: NSFetchRequest<UserCommentsCD> = UserCommentsCD.fetchRequest()
        let customPredicate = NSPredicate(format: "postId = %@", String(id))
        fetchRequest.predicate = customPredicate
        do {
            let results = try CoreDataStack.shared.managedContext.fetch(fetchRequest)
            return results
        } catch {
            print("Fatal error. Can not fetch objects")
        }
        return nil
    }
    
    // MARK: - Create NSFetchedResultsController
    
    func postsInfoFetchedResultController() -> NSFetchedResultsController<PostInfoCD> {
        let fetchRequest = NSFetchRequest<PostInfoCD>(entityName: PostInfoCD.entityName)
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \PostInfoCD.id, ascending: true)]
        fetchRequest.fetchBatchSize = 20

        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: coreDataStack.managedContext, sectionNameKeyPath: nil, cacheName: nil)
    }
}
