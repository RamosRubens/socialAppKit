//
//  PostTableViewController.swift
//  SocialKit
//
//  Created by Rubens Ferreira Ramos on 18/04/21.
//

import UIKit

class PostTableViewController: UITableViewController {
    
    private let kBaseURL = "https://jsonplaceholder.typicode.com"

    private var posts = [Post]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        if let url = URL(string: "\(kBaseURL)/posts/\(user.id)"){
        if let url = URL(string: "\(kBaseURL)/posts/1") {
            let session = URLSession.shared

            let request = URLRequest(url: url)
            
            let task = session.dataTask(with: request) { (data, resp, error) in
                if let response = resp as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 {
                    if let posts = try? JSONDecoder().decode([Post].self, from: data!) {
                        DispatchQueue.main.async {
                            self.posts = posts
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        
        let post = posts[index]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "postsCell", for: indexPath) as! PostTableViewCell
        
        cell.post = post
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "onUserSegue" {
            if let userCell = sender as? UserTableViewCell, let user = userCell.user {
                
                segue.destination.title = user.name
                
            }
        }
    }
    
}