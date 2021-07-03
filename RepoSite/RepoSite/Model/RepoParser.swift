//
//  RepoParser.swift
//  RepoSite
//
//  Created by user176911 on 7/3/21.
//

import Foundation



struct RepoParsed: Decodable {
    var items: [Item]
}


struct Item: Decodable {
    var full_name: String
    var owner: Owner
    var description: String
    var html_url: String
}

//   Siva G : ====> <====
struct Owner: Decodable {
    var login: String
    var avatar_url: String
}






//      Parsing Tree Diagram:
//                            items: [Item]
//                                     |
//                                     |
//                                     full_name,owner,description,html_url
//                                                 |
//                                                 |
//                                                 login,avatar_url

