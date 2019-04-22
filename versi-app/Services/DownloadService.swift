//
//  DownloadService.swift
//  versi-app
//
//  Created by Ricardo Herrera Petit on 4/21/19.
//  Copyright © 2019 Ricardo Herrera Petit. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class DownloadService {
    static let instance = DownloadService()
    
    func downloadTrendingReposDictArray(completion: @escaping (_ reposDictArray: [Dictionary<String,Any>]) ->() ) {
        var trendingReposArray = [Dictionary<String,Any>]()
        Alamofire.request(trendingRepoUrl).responseJSON { (response) in
            guard let json = response.result.value as? Dictionary<String,Any> else { return }
            guard let repoDictionaryArray = json["items"] as? [Dictionary<String,Any>] else { return }
            for repoDict in repoDictionaryArray {
                if trendingReposArray.count <= 9 {
                    guard let name = repoDict["name"] as? String,
                    let description = repoDict["description"] as? String,
                    let numberOfForks = repoDict["forks_count"] as? Int,
                    let language = repoDict["language"] as? String,
                    let repoUrl = repoDict["html_url"] as? String,
                    let contributorsUrl = repoDict["contributors_url"] as? String,
                    let ownerdDict = repoDict["Owner"] as? Dictionary<String,Any>,
                    let avatarUrl = ownerdDict["avatar_url"] as? String else { break }
                    
                    let repoDictionary: Dictionary<String,Any> = ["name": name, "description": description, "forks_count":numberOfForks, "language": language, "html_url": repoUrl, "contributors_url" : contributorsUrl, "avatar_url":avatarUrl]
                    
                    trendingReposArray.append(repoDictionary)
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
                self.downloadTrendingRepo(fromDictionary: dict, completion: { (returnedRepo) in
                     reposArray.append(returnedRepo)
                })
              
            }
            completion(reposArray)
        }
        
    }
    
    func downloadTrendingRepo(fromDictionary dict: Dictionary<String,Any>, completion: @escaping (_ repo:Repo) -> ())  {
        let avatarUrl = dict["avatar_url"] as! String
        let contributorsUrl = dict["contributors_url"] as! String
        let name = dict["name"] as! String
        let description = dict["description"] as! String
        let numberOfForks = dict["forks_count"] as! Int
        let language = dict["language"] as! String
        let repoUrl = dict["html_url"] as! String
        
        downloadImageFor(avatarUrl: avatarUrl) { (returnedImage) in
            self.downloadContributorsDataFor(contributorsurl: contributorsUrl, completion: { (returnedContributions) in
                let repo = Repo(image: returnedImage, name: name, description: description, numberOfForks: numberOfForks, language: language, numberOfContributors: returnedContributions, repoUrl: repoUrl)
                completion(repo)
            })
        }
        
        
        
        
    }
    
    func downloadImageFor(avatarUrl:String, completion: @escaping (_ image:UIImage) ->()) {
        Alamofire.request(avatarUrl).responseImage { (imageResponse) in
            guard let image = imageResponse.result.value else { return }
            completion(image)
        }
    }
    
    func downloadContributorsDataFor(contributorsurl: String, completion: @escaping (_ count:Int) -> ()) {
        Alamofire.request(contributorsurl).responseJSON { (response) in
            guard let json = response.result.value as? [Dictionary<String,Any>] else { return }
            if !json.isEmpty {
                let contributions = json.count
                completion(contributions)
            }
        }
    }
}
