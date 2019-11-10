//
//  Albums.swift
//  ACTO-Test
//
//  Created by CtanLI on 2019-11-10.
//  Copyright © 2019 ACTO-Test. All rights reserved.
//

import Foundation
import CoreData

@objc(Albums)
class Albums: NSManagedObject, Codable {
    enum CodingKeys: String, CodingKey {
        case userId
        case id
        case title
    }

    // MARK: - Core Data Managed Object
    @NSManaged var userId: Int64
    @NSManaged var id: Int64
    @NSManaged var title: String?

    // MARK: - Decodable
    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Albums", in: managedObjectContext) else {
            fatalError("Failed to decode User")
        }

        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try (container.decodeIfPresent(Int64.self, forKey: .userId) ?? 0)
        self.id = try (container.decodeIfPresent(Int64.self, forKey: .id) ?? 0)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
    }

    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(userId, forKey: .userId)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
    }
}
