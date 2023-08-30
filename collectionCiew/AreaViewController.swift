//
//  AreaViewController.swift
//  collectionCiew
//
//  Created by Makape Tema on 2023/04/13.
//

import UIKit

class AreaViewController: UIViewController, UISearchResultsUpdating, UITableViewDelegate, UITableViewDataSource {
    
    var areas: [Area] = []
    
    var model = [Status]()
    var searchControl = UISearchController()

    @IBOutlet var areaTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        areaTable.delegate = self
        areaTable.dataSource = self
        
        searchControl.searchResultsUpdater = self
        navigationItem.searchController = searchControl
        
        registerNibs()
        fetchData()
    }
    
    private func fetchData() {
        NetworkManager.shared.MockAreas { [weak self] searchResult, error in
            guard let searchResult = searchResult else { return }
            self?.areas = searchResult.areas ?? []
            self?.areaTable.reloadData()
        }

//        NetworkManager.shared.getAreas(searchText: "Pretoria") { [weak self] searchResult, error inß
//            guard let searchResult = searchResult else { return }
//            self?.areas = searchResult.areas ?? []
//            self?.tableView.reloadData()
//        }
    }

    private func registerNibs() {
        areaTable.register(UINib(nibName: String(describing: AreaTableViewCell.self), bundle: .main), forCellReuseIdentifier: String(describing: AreaTableViewCell.self))
    }
    
    //searcha
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return areas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AreaTableViewCell.self), for: indexPath) as? AreaTableViewCell

        let area = areas[indexPath.row]
        cell?.areaNameLabel.text = area.name
        
        return cell ?? UITableViewCell()
    }
    
    func downloadJSON(completed: @escaping () -> ()) {
        let url = URL(string: "https://thronesapi.com/api/v2/Characters")
        
        URLSession.shared.dataTask(with: url!) { data, response, err in
            
            if err == nil {
                do {
                    self.model = try JSONDecoder().decode([Status].self, from: data!)
                    DispatchQueue.main.async {
                        completed()
                    }
                }
                catch {
                    print("error fetching data from api")
                }
            }
        }.resume()
    }
}
