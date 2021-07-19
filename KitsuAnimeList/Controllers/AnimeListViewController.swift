//
//  AnimeListViewController.swift
//  KitsuAnimeList
//
//  Created by Кирилл Тила on 18.07.2021.
//

import UIKit

class AnimeListViewController: UIViewController {
    
    private var dataAnime: [CurrentDataAnime]?
    private let networkService = NetworkService()
    private let coreDataStack: CoreDataStack
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.dataSource = self
        table.delegate = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Список аниме"
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchAnimeList()
    }
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func fetchAnimeList() {
        let queue = DispatchQueue.global(qos: .background)
        
        queue.async {
            self.networkService.fetchAnimeList() { [weak self] result in
                guard let self = self else {
                    return
                }
                
                switch result {
                case .success(let data):
                    self.dataAnime = data
                    self.coreDataStack.setAnimeList(content: data)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                case .failure(let error):
                    
                    self.dataAnime = self.coreDataStack.fetchAnimeList()
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                    print("error: \(error)")
                    
                }
            }
        }
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
 
}

extension AnimeListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dataAnime = dataAnime else {
            return 0
        }
        return dataAnime.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if let anime = dataAnime {
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = anime[indexPath.row].enTitle
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let dataAnime = dataAnime else {
            return
        }
        
        let vc = DetailsViewController(dataAnime: dataAnime[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
