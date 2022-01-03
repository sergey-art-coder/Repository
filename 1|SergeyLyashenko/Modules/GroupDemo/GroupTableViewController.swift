//
//  GroupTableViewController.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 18.04.2021.
//

import UIKit

class GroupTableViewController: UITableViewController {
    
    var myGroups = [Group]()
    var seletedGroups: Group?
    
    
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
        // получаем нужную нам группу обращаясь к массиву групп
        let group = myGroups[indexPath.row]
        cell.nameGroupLabel.text = group.name
        cell.photoImageView.image = group.image
        return cell
    }
    // возвращаемся на контроллер
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        // Проверка по идентификатору верный ли переход с ячейки
        if segue.identifier == "addGroup",
           // Проверяем то что источник в этом переходе это объект класса AllGroupTableViewController, если это так то забираем выбранную группу 
           let sourceVC = segue.source as? AllGroupTableViewController, let selectedGroup = sourceVC.selectedGroup {
            // Если нет группы в списке то добавляем выбранную группу
            if !myGroups.contains(selectedGroup) {
                myGroups.append(selectedGroup)
                // После добавления группы обновляем таблицу
                tableView.reloadData()
            }
        }
    }
    
    // метод canEditRowAt indexPath обозначает можем ли мы конкретную ячейку редактировать
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row == 0 {
            return false
        }
        return true
    }
    
    // удаление групп
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // удаляем группу из массива городов
            myGroups.remove(at: indexPath.row)
            // удаляем группу из таблицы
            tableView.deleteRows(at: [indexPath], with: .fade)
        }    
    }
}
