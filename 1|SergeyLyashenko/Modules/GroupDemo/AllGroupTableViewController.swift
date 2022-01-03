//
//  AllGroupTableViewController.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 18.04.2021.
//

import UIKit


class AllGroupTableViewController: UITableViewController {
    
    var myGroups = [
        Group(name: "Swift для iOS", image: UIImage(named: "group2")!),
        Group(name: "Mobile Dev Jobs", image: UIImage(named: "group1")!),
        Group(name: "Swift, Xcode", image: UIImage(named: "group3")!),
        Group(name: "Флуд-Swift", image: #imageLiteral(resourceName: "group5")),
        Group(name: "Swift разработка", image: #imageLiteral(resourceName: "group4"))
    ]
    
    var selectedGroup: Group?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    // MARK: - Table view data source
    // количество секций
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // количество ячеек в секции соответствует колличеству друзей
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myGroups.count
    }
    
    // запонение ячеек
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // получить ячейку класса GroupTableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! GroupTableViewCell
        // получаем нужного нам друга обращаясь к массиву друзей
        let group = myGroups[indexPath.row]
        cell.nameGroupLabel.text = group.name
        cell.photoImageView.image = group.image
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // кратковременное подсвечивание при нажатии на ячейку
        tableView.deselectRow(at: indexPath, animated: true)
        // Выбираем группу (запоминаем)
        selectedGroup = myGroups[indexPath.row]
        // указываем то что нужно запустить переход "addGroup"
        performSegue(withIdentifier: "addGroup", sender: self)
    }
}

