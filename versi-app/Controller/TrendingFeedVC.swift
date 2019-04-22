//
//  ViewController.swift
//  versi-app
//
//  Created by Ricardo Herrera Petit on 4/21/19.
//  Copyright © 2019 Ricardo Herrera Petit. All rights reserved.
//

import UIKit

class TrendingFeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "trendingRepoCell", for: indexPath) as? TrendingRepoCell else { return UITableViewCell() }
        let repo = Repo(image: UIImage(named: "searchIconLarge")!, name: "SWIFT", description: "Apples Programming Language", numberOfForks: 357, language: "Swift", numberOfContributors: 562, repoUrl: "www.google.com")
        cell.configureCell(repo: repo)
        return cell
    }
}

