//
//  DownloadService.swift
//  versi-app
//
//  Created by Ricardo Herrera Petit on 4/21/19.
//  Copyright © 2019 Ricardo Herrera Petit. All rights reserved.
//

import Foundation
import Alamofire

class DownloadService {
    static let instance = DownloadService()
    
    func downloadTrendingReposDictArray(completion: @escaping (_ reposDictArray: [Dictionary<String,Any>]) ->() ) {
        var trendingReposArray = [Dictionary<String,Any>]()
        Alamofire.request(trendingRepoUrl).responseJSON { (response) in
            guard let json = response.result.value as? Dictionary<String,Any> else { return }
            guard let repoDictionaryArray = json["items"] as? [Dictionary<String,Any>] else { return }
            for repoDict in repoDictionaryArray {
                if trendingReposArray.count <= 10 {
                    trendingReposArray.append(repoDict)
                } else {
                    break
                }
            }
            completion(trendingReposArray)
        }
       
    }
}
