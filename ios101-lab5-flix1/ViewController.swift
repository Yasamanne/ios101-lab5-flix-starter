//
//  ViewController.swift
//  ios101-lab5-flix1
//

import UIKit
import Nuke

// TODO: Add table view data source conformance
class ViewController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        
        // Get the movie-associated table view row
        let post = posts[indexPath.row]
        
        for photo in post.photos{
            let imageUrl = photo.originalSize.url
            Nuke.loadImage(with: imageUrl, into: cell.imagePoster)
        }
           

            // Configure the cell (i.e., update UI elements like labels, image views, etc.)
//            cell.textLabel?.text = post.summary
        cell.summaryText.text = post.summary
        return cell
    }
    


    // TODO: Add table view outlet

    @IBOutlet weak var tableView: UITableView!
    
    // TODO: Add property to store fetched movies array
    
    // A property to store the movies we fetch.
    // Providing a default value of an empty array (i.e., `[]`) avoids having to deal with optionals.
    private var posts: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO: Assign table view data source
        tableView.dataSource = self

        fetchMovies()
    }

    // Fetches a list of popular movies from the TMDB API
    private func fetchMovies() {

        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork/posts/photo?api_key=1zT8CiXGXFcQDyMFG7RtcfGLwTdDjFUJnZzKJaWTmgyK4lKGYk")!
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("❌ Error: \(error.localizedDescription)")
                return
            }

            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, (200...299).contains(statusCode) else {
                print("❌ Response error: \(String(describing: response))")
                return
            }

            guard let data = data else {
                print("❌ Data is NIL")
                return
            }

            do {
                let blog = try JSONDecoder().decode(BlogResponse.self, from: data)

                DispatchQueue.main.async { [weak self] in

                    let posts = blog.response.posts
                    
                    print("✅ We got \(posts.count) posts!")
                    for post in posts {
                        print("🍏 Summary: \(post.summary)")
                    }
                    
                    self?.posts = posts
                    self?.tableView.reloadData()
                }

            } catch {
                print("❌ Error decoding JSON: \(error.localizedDescription)")
            }
        }
        session.resume()
    }
}
