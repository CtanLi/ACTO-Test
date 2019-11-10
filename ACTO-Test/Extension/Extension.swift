//
//  Extension.swift
//  ACTO-Test
//
//  Created by CtanLI on 2019-11-10.
//  Copyright © 2019 ACTO-Test. All rights reserved.
//

import UIKit
import CoreData

// MARK: - Helpers

let imageCache = NSCache<NSString, UIImage>()
extension UIImageView {
    func loadImageUsingCacheWithURLString(urlString: String) {
        if urlString == "" {
            return
        }
        self.image = nil
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
            return
        }
        let url = URL(string: urlString)!
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil {
                print(error ?? "")
                return
            }
            DispatchQueue.main.async {
                if let downloadedImages = UIImage(data: data!) {
                    imageCache.setObject(downloadedImages, forKey: urlString as NSString)
                    self.image = downloadedImages
                }
            }
        }).resume()
    }
}

extension UIViewController {
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension CodingUserInfoKey {
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")
}

public extension UIViewController {
    func clearStorage(entity: String) {
          let managedObjectContext = PersistanceService.context
          let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
          let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
          do {
              try managedObjectContext.execute(batchDeleteRequest)
          } catch let error as NSError {
              print(error)
          }
      }
}
