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
    
    private let newsTitlelabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .medium)
        return label
    }()
    
    private let subTitileLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemRed
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(newsTitlelabel)
        contentView.addSubview(subTitileLabel)
        contentView.addSubview(newsImageView)
        print("dnflfk lkdflkf lkflkf")

    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        newsTitlelabel.frame = CGRect(x: 10,
                                      y: 0,
                                      width: contentView.frame.size.width - 120,
                                      height: contentView.frame.size.height/2)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(with viewModel: NewsTableViewCellViewModel){
        newsTitlelabel.text = viewModel.title
        subTitileLabel.text = viewModel.subTitle
        
        if let data = viewModel.imageData{
            newsImageView.image = UIImage(data: data)
        }
        else{
            
        }
    }

}
