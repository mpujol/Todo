//
//  APIClient.swift
//  ToDo
//
//  Created by Michael Pujol on 9/25/18.
//  Copyright © 2018 Michael Pujol. All rights reserved.
//

import Foundation

class APIClient {

    lazy var session: SessionProtocol = URLSession.shared
    
    func loginUser(withName username: String, password: String, completion: @escaping (Token?, Error?) -> Void) {
        
        let query = "username=\(username)&password=\(password)"
        guard let url = URL(string: "https://awesometodos.com/login?\(query)") else { fatalError() }
        session.dataTask(with: url) { (data, response, error) in
            //
        }
    }
    
}

extension URLSession: SessionProtocol {
    
}

protocol SessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}
