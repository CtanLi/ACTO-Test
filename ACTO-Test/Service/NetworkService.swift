//
//  NetworkService.swift
//  ACTO-Test
//
//  Created by CtanLI on 2019-11-10.
//  Copyright © 2019 ACTO-Test. All rights reserved.
//

import Foundation
import Alamofire

struct NetworkState {
    var isConnected: Bool {
        // isReachable checks for wwan, ethernet, and wifi, if
        // you only want 1 or 2 of these, the change the .isReachable
        // at the end to one of the other options.
        return NetworkReachabilityManager(host: "www.google.com")!.isReachable
    }
}
