//
//  ViewController.swift
//  News App
//
//  Created by VARGHESE T MASCREEN on 28/12/22.
//

import UIKit
import SafariServices

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
//    private let tableView: UITableView = {
//        let table = UITableView()
//        table.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
//         return table
//    }()
    @IBOutlet weak var tableView: UITableView!
    
    private var articles = [Article]()
    private var viewModels = [NewsTableViewCellViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        title = "News"
        view.backgroundColor = .systemBackground
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: "NewsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "NewsTableViewCell")
        
        APICaller.shared.getTopStories{[weak self] result in
            switch result{
            case .success(let articles):
                self?.articles = articles
                self?.viewModels = articles.compactMap({
                    NewsTableViewCellViewModel(
                        title: $0.title,
                        subTitle: $0.description ?? "No Description",
                        imageURL: URL(string: $0.urlToImage ?? ""))
                })
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("jhbh khhhbjh")

        return viewModels.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else{
            
            fatalError()
        }
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = articles[indexPath.row]
        
        guard let url = URL(string: article.url ?? "") else{
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc,animated: true)
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt  indexPath: IndexPath) -> CGFloat {
        return 375
    
    }
    

    

}

