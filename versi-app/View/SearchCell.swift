//
//  SearchCell.swift
//  versi-app
//
//  Created by Ricardo Herrera Petit on 4/23/19.
//  Copyright © 2019 Ricardo Herrera Petit. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {

    @IBOutlet weak var repoNameLbl: UILabel!
    @IBOutlet weak var repoDescLbl: UILabel!
    @IBOutlet weak var forksCountLbl: UILabel!
    @IBOutlet weak var languageLbl: UILabel!
    @IBOutlet weak var backView: UIView!
    
    private var repoUrl: String?
    
    func configureCell(repo:Repo) {
        repoNameLbl.text = repo.name
        repoDescLbl.text = repo.description
        forksCountLbl.text = String(describing: repo.numberOfForks)
        languageLbl.text = repo.language
        repoUrl = repo.repoUrl
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.cornerRadius = 15
        
    }


}
