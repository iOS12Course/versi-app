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
                if trendingReposArray.count <= 9 {
                    trendingReposArray.append(repoDict)
                } else {
                    break
                }
            }
            completion(trendingReposArray)
        }
    }
    
    func downloadTrendingRepos(completion: @escaping (_ reposArray: [Repo]) -> ()) {
        var reposArray = [Repo]()
        downloadTrendingReposDictArray { (trendingReposDictArray) in
            for dict in trendingReposDictArray {
               let repo = self.downloadTrendingRepo(fromDictionary: dict)
               reposArray.append(repo)
            }
            completion(reposArray)
        }
        
    }
    
    func downloadTrendingRepo(fromDictionary dict: Dictionary<String,Any>) -> Repo {
       //let avatarUrl = dict["avatar_url"] as! String
        let name = dict["name"] as! String
        let description = dict["description"] as! String
        let numberOfForks = dict["forks_count"] as! Int
        let language = dict["language"] ?? "SWIFT"
        let repoUrl = dict["html_url"] as! String
        
        let repo = Repo(image: UIImage(named: "searchIconLarge")!, name: name, description: description, numberOfForks: numberOfForks, language: "SWIFT", numberOfContributors: 123, repoUrl: repoUrl)
        
        return repo
    }
}
