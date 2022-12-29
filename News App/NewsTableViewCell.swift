//
//  NewsTableViewCell.swift
//  News App
//
//  Created by VARGHESE T MASCREEN on 28/12/22.
//

import UIKit

class NewsTableViewCellViewModel{
    let title: String
    let subTitle: String
    let imageURL: URL?
    var imageData: Data? = nil
    
    init(title: String, subTitle: String, imageURL: URL?, imageData: Data? = nil) {
        self.title = title
        self.subTitle = subTitle
        self.imageURL = imageURL
        self.imageData = imageData
    }
}
class NewsTableViewCell: UITableViewCell {
    static let identifier = "NewsTableViewCell"
    
    @IBOutlet weak var newsImageView: UIImageView!
    
    @IBOutlet weak var newsTitleLabel: UILabel!
    //    private let newsTitlelabel: UILabel = {
    @IBOutlet weak var subTitleLabel: UILabel!
    //        let label = UILabel()
//        label.font = .systemFont(ofSize: 25, weight: .medium)
//        return label
//    }()
//
//    private let subTitileLabel: UILabel = {
//        let label = UILabel()
//        label.font = .systemFont(ofSize: 18, weight: .regular)
//        return label
//    }()
//
//    private let newsImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.backgroundColor = .systemRed
//        imageView.contentMode = .scaleAspectFill
//        return imageView
//    }()
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        contentView.addSubview(newsTitleLabel)
//        contentView.addSubview(subTitleLabel)
//        contentView.addSubview(newsImageView)
//
//    }
    
//    required init?(coder: NSCoder) {
//        fatalError()
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//    }
//
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(with viewModel: NewsTableViewCellViewModel){
        newsTitleLabel.text = viewModel.title
        subTitleLabel.text = viewModel.subTitle

        if let data = viewModel.imageData{
            newsImageView.image = UIImage(data: data)
        }
        else if let url = viewModel.imageURL{
            URLSession.shared.dataTask(with: url){ data,_ , error in
                guard let data = data , error == nil else {
                    return
                }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self.newsImageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }

}
