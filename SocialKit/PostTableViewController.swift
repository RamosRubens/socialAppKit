//
//  PostTableViewController.swift
//  SocialKit
//
//  Created by Rubens Ferreira Ramos on 18/04/21.
//

import UIKit

class PostTableViewController: UITableViewController {
    
    private let kBaseURL = "https://jsonplaceholder.typicode.com"

    var user: User?
    
    var posts: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let url = URL(string: "\(kBaseURL)/posts/\(user!.id)"){
            print(url)
            let session = URLSession.shared
            let request = URLRequest(url: url)
            let task = session.dataTask(with: request) { (data, resp, error) in
                if let response = resp as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 {
                    print(response.statusCode)
                    if let posts = try? JSONDecoder().decode(Post.self, from: data!) {
                        DispatchQueue.main.async {
                            self.posts = posts
                            self.tableView.reloadData()
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        
        let post = posts
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "postsCell", for: indexPath) as! PostTableViewCell
        
        cell.post = post
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
