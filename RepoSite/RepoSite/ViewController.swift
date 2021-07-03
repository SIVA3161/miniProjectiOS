//
//  ViewController.swift
//  RepoSite
//
//  Created by user176911 on 7/3/21.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
        
        //   Siva G : ====>Helps to dismiss the iOS keyboard when tapping anywhere outside the keyboard <====
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
               view.addGestureRecognizer(tap)
    }


}

