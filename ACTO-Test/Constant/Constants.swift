//
//  Constants.swift
//  ACTO-Test
//
//  Created by CtanLI on 2019-11-10.
//  Copyright © 2019 ACTO-Test. All rights reserved.
//

import Foundation

class BaseAPIClient {
    class func urlFromPath(path: String) -> String {
        let endPointURL = "https://jsonplaceholder.typicode.com/"
        let requestUrl = String(format: "%@%@", endPointURL, path)
        return  requestUrl
    }
}

struct paths {

    //getUsers
    static let users = "users/"
    
    //getAlbums
    static let albums = "albums/"
    
    //getPhotos
     static let photos = "photos/"
}
