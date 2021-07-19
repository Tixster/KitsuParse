//
//  DetailsViewController.swift
//  KitsuAnimeList
//
//  Created by Кирилл Тила on 19.07.2021.
//

import UIKit

class DetailsViewController: UIViewController {
    
    private let dataAnime: CurrentDataAnime
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let content = UIView()
        content.translatesAutoresizingMaskIntoConstraints = false
        return content
    }()
    
    private let titleLable: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let otherTitlesLable: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let synopsisLable: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setubLables()
        configure()
    }
    
    init(dataAnime: CurrentDataAnime) {
        self.dataAnime = dataAnime
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setubLables() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(titleLable)
        contentView.addSubview(otherTitlesLable)
        contentView.addSubview(synopsisLable)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            titleLable.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            otherTitlesLable.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 10),
            otherTitlesLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            otherTitlesLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            synopsisLable.topAnchor.constraint(equalTo: otherTitlesLable.bottomAnchor, constant: 10),
            synopsisLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            synopsisLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            synopsisLable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    private func configure() {
        titleLable.text = dataAnime.enTitle
        otherTitlesLable.text = "\(dataAnime.enJpTitle), \(dataAnime.jpTitle)"
        synopsisLable.text = dataAnime.synopsis
        title = dataAnime.enTitle
    }
    
}


