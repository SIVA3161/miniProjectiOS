//
//  ViewController.swift
//  RepoSite
//
//  Created by user176911 on 7/3/21.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var RepoArr = ["Siva"] {
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
        tableView.reloadData()
        
        
        //   Siva G : ====>Helps to dismiss the iOS keyboard when tapping anywhere outside the keyboard <====
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
               view.addGestureRecognizer(tap)
        
    }
         
       //   Siva G : ====> SearchBar functionalities <====

        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.endEditing(true)
            spinner.startAnimating()
            tableView.backgroundView = spinner
            guard let searchBarText = searchBar.text else {
                return
            }
            let repoRequest = RepoSiteURLController(searchRepo: searchBarText)
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
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchBar.text?.count == 0 {
                searchResults = []
                DispatchQueue.main.async {
                    searchBar.resignFirstResponder()
                    self.spinner.isHidden = true
                }
            }
        }

}
   
                    //   Siva G : ====> TableView has been extented from ViewController <====

extension ViewController: UITableViewDelegate ,UITableViewDataSource {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! RepoTableViewCell
           
           let repo = searchResults[indexPath.row]
          
           
         
           if let url = URL(string: (repo.owner?.avatar_url)!) {
               if let image = try? Data(contentsOf: url) {
                   cell.repoAvatar.image = UIImage(data: image)
               }
           }
           
           cell.fullName.text = repo.full_name
           
           
           if let ownerLogin = repo.owner?.login {
               cell.loginLbl.addLeading(image: UIImage(systemName: "paperplane.fill", withConfiguration: symbolConfiguration)!, text: ownerLogin)
           }
           
           
           if let description = repo.description {
               cell.descriptionLbl.addLeading(image: UIImage(systemName: "car")!, text: description)
           }
           
          
           return cell
       }
       
       override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           if let url = URL(string: searchResults[indexPath.row].html_url!) {
               let safariVC = SFSafariViewController(url: url)
               present(safariVC, animated: true, completion: nil)
           }
       }
    
    
}
