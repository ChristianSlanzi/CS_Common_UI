//
//  NavigationBar.swift
//  CS_Common_UI
//
//  Created by Christian Slanzi on 30.10.20.
//

import Foundation

public struct NavigationBarModelView {
    var imageName: String?
    var titleText: String?
    var subtitleText: String?
    
    public init(titleText: String?, subtitleText: String?, imageName: String?) {
        self.titleText = titleText
        self.subtitleText = subtitleText
        self.imageName = imageName
    }
}

public class NavigationBar: CustomView {
    //TODO: does it need to be a UINavigationBar or is it just a custom view?
    
    var navigationBarModelView: NavigationBarModelView! {
        didSet {
            if let name = navigationBarModelView.imageName {
               imageView.image = UIImage(named: name)
            }
            titleLabel.text = navigationBarModelView.titleText
            subtitleLabel.text = navigationBarModelView.subtitleText
                
            self.layoutIfNeeded()
        }
    }
    
    lazy var imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
       let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 34)
        titleLabel.numberOfLines = 2
        return titleLabel
    }()
    
    lazy var subtitleLabel: UILabel = {
       let subtitleLabel = UILabel()
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.textColor = .white
        subtitleLabel.font = .systemFont(ofSize: 15)
        subtitleLabel.textAlignment = .left
        return subtitleLabel
    }()
    
    public convenience init(modelView: NavigationBarModelView) {
        //self.init(modelView: modelView)
        self.init()
        setModelView(modelView)
    }
    
    func setModelView(_ modelView: NavigationBarModelView) {
        self.navigationBarModelView = modelView
    }
    
    public override func setupViews() {
        super.setupViews()
        
        //image
        self.addSubview(imageView)
        
        // title
        //titleLabel.text = titleText
        self.addSubview(titleLabel)
        
        // subtitle
        //subtitleLabel.text = subtitleText
        self.addSubview(subtitleLabel)
    }
    public override func setupActions() {
        
    }
    
    public override func setupConstraints() {
        super.setupConstraints()
        
        NSLayoutConstraint.activate([
        subtitleLabel.topAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
        subtitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
        subtitleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9)
        ])
        
        NSLayoutConstraint.activate([
        imageView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 5),
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
        imageView.widthAnchor.constraint(equalToConstant: 40),
        imageView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
        titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
    }
}
