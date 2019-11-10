//
//  Photos.swift
//  ACTO-Test
//
//  Created by CtanLI on 2019-11-10.
//  Copyright © 2019 ACTO-Test. All rights reserved.
//

import Foundation
import CoreData

@objc(Photos)
class Photos: NSManagedObject, Codable {
    enum CodingKeys: String, CodingKey {
        case albumId
        case id
        case title
        case url
        case thumbnailUrl
    }

    // MARK: - Core Data Managed Object
    @NSManaged var albumId: Int64
    @NSManaged var id: Int64
    @NSManaged var title: String?
    @NSManaged var url: String?
    @NSManaged var thumbnailUrl: String?

    // MARK: - Decodable
    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Photos", in: managedObjectContext) else {
            fatalError("Failed to decode User")
        }

        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.albumId = try (container.decodeIfPresent(Int64.self, forKey: .albumId) ?? 0)
        self.id = try (container.decodeIfPresent(Int64.self, forKey: .id) ?? 0)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.thumbnailUrl = try container.decodeIfPresent(String.self, forKey: .thumbnailUrl)
    }

    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(albumId, forKey: .albumId)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(url, forKey: .url)
        try container.encode(thumbnailUrl, forKey: .thumbnailUrl)
    }
}
