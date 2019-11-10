//
//  AlbumsController.swift
//  ACTO-Test
//
//  Created by CtanLI on 2019-11-10.
//  Copyright © 2019 ACTO-Test. All rights reserved.
//

import UIKit
import CoreData

class AlbumsController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var albumsTableView: UITableView!
    
    // MARK: properties
      
    var userId = Int()
    var albums = [Albums]() {
        didSet {
            albumsTableView.reloadData()
        }
    }
    
     //MARK: Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Albums"
        checkNetworkState()
    }

    //MARK: operations
       
       func checkNetworkState() {
            if NetworkState().isConnected {
                clearStorage(entity: "Albums")
                getAlbums()
           } else {
                fetchFromStorage()
           }
       }
    
     //MARK: implementations
    
    func getAlbums()  {
        let getAlbumsUrl = BaseAPIClient.urlFromPath(path: paths.albums)
        APIService.shared.fetchGenericData(method: .get, urlString: getAlbumsUrl) { (result: [Albums]) in
            if result.count != 0 {
                let albums = result.filter { $0.userId == self.userId }
                self.albums.append(contentsOf: albums)
            } else {
                self.alert(message: "An error occurred please check you network state and try again.")
            }
        }
    }
    
    func fetchFromStorage() {
        let managedObjectContext = PersistanceService.context
        let fetchRequest = NSFetchRequest<Albums>(entityName: "Albums")
        let sortDescriptor = NSSortDescriptor(key: "userId", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
             let albums = try managedObjectContext.fetch(fetchRequest)
             let filteredAlbums = albums.filter { $0.userId == self.userId }
             self.albums.append(contentsOf: filteredAlbums)
        } catch let error {
            print(error)
        }
    }

     //MARK: Delegates
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumsCell") as! AlbumsCell
        cell.albums = albums[indexPath.row]
      return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! AlbumsCell
        let storyBoard = UIStoryboard(name: "Main", bundle:nil)
        let albumsController = storyBoard.instantiateViewController(withIdentifier: "PhotosController") as! PhotosController
        albumsController.albumId = Int(truncatingIfNeeded: cell.albums.id) 
        navigationController?.pushViewController(albumsController, animated: true)
    }
}
