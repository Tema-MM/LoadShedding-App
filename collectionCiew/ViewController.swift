//
//  ViewController.swift
//  collectionCiew
//
//  Created by Makape Tema on 2023/04/12.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource/*, UISearchResultsUpdating */{
   
    //static let shared = NetworkManager()
    
    var areas: [Area] = []
    
    @IBOutlet var stage: UILabel!
    
    @IBOutlet var table: UITableView!
     
    var id: String?
    
    var theModel = [Status]()
    
    var models = [Model]()
    
    //var searchControl = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //title = "LoadShedding"
        
        
        models.append(Model(text: "Gauteng", imageName: "Image"))
        models.append(Model(text: "Limpopo", imageName: "Image0"))
        models.append(Model(text: "Mpumalanga", imageName: "Image1"))
        models.append(Model(text: "KwaZulu-Natal", imageName: "Image2"))
        models.append(Model(text: "Free State", imageName: "Image3"))
        models.append(Model(text: "Eastern Cape", imageName: "Image4"))
        models.append(Model(text: "Western Cape", imageName: "Image"))
        models.append(Model(text: "Northern Cape", imageName: "Image0"))
        models.append(Model(text: "North West", imageName: "Image1"))
        
        table.register(CollectTableViewCell.nib(), forCellReuseIdentifier: CollectTableViewCell.identifier)
        table.delegate = self
        table.dataSource = self
        
        //api
        NetworkManager.shared.getStatus { [weak self] status, error in
            let name = status?.status?.eskom?.name
            let current = status?.status?.eskom?.stage
            // //look up query parameters
            self?.stage.text = current
            
        }
        
        //search
//        searchControl.searchResultsUpdater = self
//        navigationItem.searchController = searchControl
        
        stage.text = "Stage ..."
        //dataFetch()
    }
    
    private func fetchData() {
        NetworkManager.shared.MockAreas { [weak self] searchResult, error in
            guard let searchResult = searchResult else { return }
            self?.areas = searchResult.areas ?? []
            self?.table.reloadData()
        }

//        NetworkManager.shared.getAreas(searchText: "Pretoria") { [weak self] searchResult, error in
//            guard let searchResult = searchResult else { return }
//            self?.areas = searchResult.areas ?? []
//            self?.tableView.reloadData()
//        }
    }
    
    func dataFetch() {
        guard let id = self.id else { return }
        
        NetworkManager.shared.getAreaDetail(id: id) { [weak self] areaDetail, error in
            //self?.stageLabel.text = areaDetail?.events?.first?.note
           
        }
    }
    
    //searcha
//    func updateSearchResults(for searchController: UISearchController) {
//        guard let text = searchController.searchBar.text else {
//            return
//        }
//
//    }

    //table
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return areas.count
//    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
        //return areas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: CollectTableViewCell.identifier, for: indexPath) as! CollectTableViewCell
        cell.configure(with: models)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250.0
    }

    //api
    func downloadJSON(completed: @escaping () -> ()) {
        let url = URL(string: "https://thronesapi.com/api/v2/Characters")
        
        URLSession.shared.dataTask(with: url!) { data, response, err in
            
            if err == nil {
                do {
                    self.theModel = try JSONDecoder().decode([Status].self, from: data!)
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

struct Model {
    let text: String
    let imageName: String
    
    init(text: String, imageName: String) {
        self.text = text
        self.imageName = imageName
    }
}
