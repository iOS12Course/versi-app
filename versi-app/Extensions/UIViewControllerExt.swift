//
//  UIViewControllerExt.swift
//  versi-app
//
//  Created by Ricardo Herrera Petit on 4/23/19.
//  Copyright © 2019 Ricardo Herrera Petit. All rights reserved.
//

import UIKit
import SafariServices

extension UIViewController {
    func presentSFSafariVCFor(url:String) {
        let readmeUrl = URL(string: url + readmeSegment)
        let safariVC = SFSafariViewController(url: readmeUrl!)
        present(safariVC, animated: true, completion: nil)
    }
}
