import Foundation
import CoreData


extension ItemEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemEntity> {
        return NSFetchRequest<ItemEntity>(entityName: "ItemEntity")
    }

    @NSManaged public var nameAttribute: String?
    @NSManaged public var batchNoAttribute: String?
    @NSManaged public var imageAttribute: Data?

}

extension ItemEntity : Identifiable {

}
