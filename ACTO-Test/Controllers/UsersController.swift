//
//  ViewController.swift
//  ACTO-Test
//
//  Created by CtanLI on 2019-11-10.
//  Copyright © 2019 ACTO-Test. All rights reserved.
//

import UIKit
import CoreData

class UsersController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var usersTableView: UITableView!
    
    // MARK: properties
    
    var users = [Users]() {
        didSet {
            usersTableView.reloadData()
        }
    }
    
     //MARK: Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Users"
        checkNetworkState()
    }
    
     //MARK: operations
    
    func checkNetworkState() {
        if NetworkState().isConnected {
            clearStorage(entity: "Users")
            getUsers()
        } else {
            fetchFromStorage()
        }
    }
    
     //MARK: implementations
    
    func getUsers()  {
        let getUsersUrl = BaseAPIClient.urlFromPath(path: paths.users)
        APIService.shared.fetchGenericData(method: .get, urlString: getUsersUrl) { (result: [Users]) in
            if result.count != 0 {
                self.users.append(contentsOf: result)
            } else {
                self.alert(message: "An error occurred please check you network state and try again.")
            }
        }
    }
    
    func fetchFromStorage() {
           let managedObjectContext = PersistanceService.context
           let fetchRequest = NSFetchRequest<Users>(entityName: "Users")
           let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
           fetchRequest.sortDescriptors = [sortDescriptor]
           do {
                let users = try managedObjectContext.fetch(fetchRequest)
                self.users.append(contentsOf: users)
           } catch let error {
               print(error)
           }
       }

    //MARK: Delegates
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "UsersCell") as! UsersCell
          cell.users = users[indexPath.row]
        return cell
      }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! UsersCell
        let storyBoard = UIStoryboard(name: "Main", bundle:nil)
        let albumsController = storyBoard.instantiateViewController(withIdentifier: "AlbumsController") as! AlbumsController
        albumsController.userId = Int(truncatingIfNeeded: cell.users.id)
        navigationController?.pushViewController(albumsController, animated: true)
    }
}
