//
//  APIService.swift
//  ACTO-Test
//
//  Created by CtanLI on 2019-11-10.
//  Copyright © 2019 ACTO-Test. All rights reserved.
//

import Foundation
import Alamofire
import CoreData

class APIService {
    static let shared = APIService()
    func fetchGenericData<T: Decodable>(method: HTTPMethod, urlString: String, completion: @escaping (T) -> ()) {
        guard let url = URL(string: urlString) else { return }
        Alamofire.request(url, method: method, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseData { (responseObject) in
            if responseObject.result.isSuccess {
                guard let data = responseObject.result.value else { return }
                do {
                    guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
                       fatalError("Failed to retrieve context")
                    }
                    let decoder = JSONDecoder()
                    decoder.userInfo[codingUserInfoKeyManagedObjectContext] = PersistanceService.context
                    let object = try decoder.decode(T.self, from: data)
                    PersistanceService.saveContext()
                    DispatchQueue.main.async {
                        completion(object)
                    }
                } catch let jsonErr {
                    print("Failed to serialize json:", jsonErr.localizedDescription)
                }
            } else if responseObject.result.isFailure {
                let error = responseObject.result.error! as NSError
                print("Request failed with error: \(error.description)")
            }
        }
    }
}
