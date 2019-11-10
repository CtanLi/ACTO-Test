//
//  Users.swift
//  ACTO-Test
//
//  Created by CtanLI on 2019-11-10.
//  Copyright © 2019 ACTO-Test. All rights reserved.
//

import Foundation
import CoreData

@objc(Users)
class Users: NSManagedObject, Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case username
        case email
        case address
        case company
        case phone
        case website
    }

    // MARK: - Core Data Managed Object
    @NSManaged var id: Int16
    @NSManaged var username: String?
    @NSManaged var name: String?
    @NSManaged var email: String?
    @NSManaged var address: Address?
    @NSManaged var company: Company?
    @NSManaged var phone: String?
    @NSManaged var website: String?

    // MARK: - Decodable
    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Users", in: managedObjectContext) else {
            fatalError("Failed to decode User")
        }

        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try (container.decodeIfPresent(Int16.self, forKey: .id) ?? 0)
        self.username = try container.decodeIfPresent(String.self, forKey: .username)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.address = try container.decodeIfPresent(Address.self, forKey: .address)
        self.company = try container.decodeIfPresent(Company.self, forKey: .company)
        self.phone = try container.decodeIfPresent(String.self, forKey: .phone)
        self.website = try container.decodeIfPresent(String.self, forKey: .website)
    }

    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(username, forKey: .username)
        try container.encode(name, forKey: .name)
        try container.encode(email, forKey: .email)
        try container.encode(address, forKey: .address)
        try container.encode(company, forKey: .company)
        try container.encode(phone, forKey: .phone)
        try container.encode(website, forKey: .website)
    }
}

@objc(Company)
class Company: NSManagedObject, Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case catchPhrase
        case bs
    }

    // MARK: - Core Data Managed Object
    @NSManaged var name: String?
    @NSManaged var catchPhrase: String?
    @NSManaged var bs: String?

    // MARK: - Decodable
    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Company", in: managedObjectContext) else {
            fatalError("Failed to decode User")
        }

        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.catchPhrase = try container.decodeIfPresent(String.self, forKey: .catchPhrase)
        self.bs = try container.decodeIfPresent(String.self, forKey: .bs)
    }

    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(catchPhrase, forKey: .catchPhrase)
        try container.encode(bs, forKey: .bs)
    }
}

@objc(Address)
class Address: NSManagedObject, Codable {
    enum CodingKeys: String, CodingKey {
        case street
        case suite
        case city
        case zipcode
        case geo
    }

    // MARK: - Core Data Managed Object
    @NSManaged var street: String?
    @NSManaged var suite: String?
    @NSManaged var city: String?
    @NSManaged var zipcode: String?
    @NSManaged var geo: Geo?

    // MARK: - Decodable
    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Address", in: managedObjectContext) else {
            fatalError("Failed to decode User")
        }

        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.street = try container.decodeIfPresent(String.self, forKey: .street)
        self.suite = try container.decodeIfPresent(String.self, forKey: .suite)
        self.city = try container.decodeIfPresent(String.self, forKey: .city)
        self.zipcode = try container.decodeIfPresent(String.self, forKey: .zipcode)
        self.geo = try container.decodeIfPresent(Geo.self, forKey: .geo)
    }

    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(street, forKey: .street)
        try container.encode(suite, forKey: .suite)
        try container.encode(city, forKey: .city)
        try container.encode(zipcode, forKey: .zipcode)
        try container.encode(geo, forKey: .geo)
    }
}

@objc(Geo)
class Geo: NSManagedObject, Codable {
    enum CodingKeys: String, CodingKey {
        case lat 
        case lng
    }

    // MARK: - Core Data Managed Object
    @NSManaged var lat: String?
    @NSManaged var lng: String?

    // MARK: - Decodable
    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Geo", in: managedObjectContext) else {
            fatalError("Failed to decode User")
        }

        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.lat = try container.decodeIfPresent(String.self, forKey: .lat)
        self.lng = try container.decodeIfPresent(String.self, forKey: .lng)
    }

    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(lat, forKey: .lat)
        try container.encode(lng, forKey: .lng)
    }
}


