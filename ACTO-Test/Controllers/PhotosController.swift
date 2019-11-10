//
//  PhotosController.swift
//  ACTO-Test
//
//  Created by CtanLI on 2019-11-10.
//  Copyright © 2019 ACTO-Test. All rights reserved.
//

import UIKit
import CoreData

class PhotosController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var photosTableView: UITableView!
    
    // MARK: properties
    
    var albumId = Int()
    var photos = [Photos]() {
        didSet {
            photosTableView.reloadData()
        }
    }
    
     //MARK: Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Photos"
        checkNetworkState()
    }
    
    //MARK: operations
          
    func checkNetworkState() {
        if NetworkState().isConnected {
            clearStorage(entity: "Photos")
            getPhoto()
        } else {
            fetchFromStorage()
        }
    }
    
    //MARK: implementations
    
    func getPhoto()  {
        let getPhotosUrl = BaseAPIClient.urlFromPath(path: paths.photos)
        APIService.shared.fetchGenericData(method: .get, urlString: getPhotosUrl) { (result: [Photos]) in
            if result.count != 0 {
                let photos = result.filter { $0.albumId == self.albumId }
                self.photos.append(contentsOf: photos)
            } else {
                self.alert(message: "An error occurred please check you network state and try again.")
            }
        }
    }
    
    func fetchFromStorage() {
           let managedObjectContext = PersistanceService.context
           let fetchRequest = NSFetchRequest<Photos>(entityName: "Photos")
           let sortDescriptor = NSSortDescriptor(key: "albumId", ascending: true)
           fetchRequest.sortDescriptors = [sortDescriptor]
           do {
                let photos = try managedObjectContext.fetch(fetchRequest)
                let filteredPhotos = photos.filter { $0.albumId == self.albumId }
                self.photos.append(contentsOf: filteredPhotos)
           } catch let error {
               print(error)
           }
       }
    
    //MARK: Delegates
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosCell") as! PhotosCell
        cell.photos = photos[indexPath.row]
      return cell
    }
}
