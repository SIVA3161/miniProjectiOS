//
//  ViewController.swift
//  RepoSite
//
//  Created by user176911 on 7/3/21.
//

import UIKit
import SafariServices

class ViewController: UIViewController {
   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    let spinner = UIActivityIndicatorView(style: .large)
     
    
    
    
    var searchResults = [Item]() {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.reloadData()
        
        
        //   Siva G : ====>Helps to dismiss the iOS keyboard when tapping anywhere outside the keyboard <====
        //   Siva G : ====> Do not use it to u'r wish...It affects RowDidSelected func <====
        
//        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
//               view.addGestureRecognizer(tap)
//
      
    }
       

}


                                      //   Siva G : ====> Custom TableView functionalities goes here<====

extension ViewController: UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate {
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoTableViewCell", for: indexPath) as! RepoTableViewCell
        let RepoArr = searchResults[indexPath.row]
        
        cell.fullName.text = RepoArr.full_name
        cell.loginLbl.text = RepoArr.owner?.login
        cell.descriptionLbl.text = RepoArr.description
        
        if let url = URL(string: (RepoArr.owner?.avatar_url)!) {
            if let img = try? Data(contentsOf: url) {
                cell.avatarImg.image = UIImage (data: img)
            }
            
        }
        cell.avatarImg.layer.cornerRadius = 40.0
        cell.avatarImg.layer.borderColor =  #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        cell.avatarImg.layer.borderWidth = 2.0
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Table element Did selected")
        if let url = URL(string: searchResults[indexPath.row].html_url!) {
            let safariVC = SFSafariViewController(url: url)
            present(safariVC, animated:  true, completion: nil)
            
        
        }
    }
    
    //   Siva G : ====> SearchBar functionalities <====

     func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
         searchBar.endEditing(true)
         spinner.startAnimating()
         spinner.color = .green
        
         tableView.backgroundView = spinner
         guard let searchBarText = searchBar.text else {
             return
         }
         let repoRequest = RepoSiteURLController(userTIP: searchBarText)
         repoRequest.getRepos { [weak self] result in
             switch result {
             case .failure(let error):
                 print(error)
             case .success(let items):
                 self?.searchResults = items
             }
         }
         tableView.reloadData()
     }
     
 
}
