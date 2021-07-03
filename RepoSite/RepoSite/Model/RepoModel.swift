//
//  RepoModel.swift
//  RepoSite
//
//  Created by user176911 @ Siva G Gurusamy on 7/3/21.
//


import Foundation

enum RepoSiteError: Error {
    case noDataAvailable
    case canNotProcessData
}

struct RepoSiteURLController {
    let finalURL: URL
    
    init(userTIP: String) {
        let baseURL = "https://api.github.com/search/repositories?q=\(userTIP)"
        guard let finalURL = URL(string: baseURL) else {fatalError()}
        
        self.finalURL = finalURL
    }
    
    func getRepos(completion: @escaping(Result<[Item], RepoSiteError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: finalURL) {data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            do {
                let decoder = JSONDecoder()
                let repoResponse = try decoder.decode(RepoParsed.self, from: jsonData)
                let repoDetails = repoResponse.items
                completion(.success(repoDetails))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
    
}
