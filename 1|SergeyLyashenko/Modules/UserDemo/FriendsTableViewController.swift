//
//  FriendsTableViewController.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 18.04.2021.
//

import UIKit

class FriendsTableViewController: UITableViewController {
    
    private var friends = [
        Friend(userName: "Stepanov Ivan", userAvatar: UIImage(named: "friend1")!, userPhotos: [#imageLiteral(resourceName: "group5"),#imageLiteral(resourceName: "friend1"),#imageLiteral(resourceName: "group4"), #imageLiteral(resourceName: "group2"), #imageLiteral(resourceName: "group3"), #imageLiteral(resourceName: "Фото Борисович")]),
        Friend(userName: "Петров Степан", userAvatar: #imageLiteral(resourceName: "group3"), userPhotos: [#imageLiteral(resourceName: "group2")]),
        Friend(userName: "Борисов Алексей", userAvatar: #imageLiteral(resourceName: "friend3"), userPhotos: [#imageLiteral(resourceName: "Фото Борисович")]),
        Friend(userName: "Ivanov Stepan", userAvatar: UIImage(named: "friend2")!, userPhotos: [#imageLiteral(resourceName: "group5"),#imageLiteral(resourceName: "friend1"),#imageLiteral(resourceName: "Фото Борисович")]),
        Friend(userName: "Степаненко Игорь", userAvatar: #imageLiteral(resourceName: "group5"), userPhotos: [#imageLiteral(resourceName: "group2")]),
        Friend(userName: "Борисов Андрей", userAvatar: #imageLiteral(resourceName: "group3"), userPhotos: [#imageLiteral(resourceName: "Фото Борисович")]),
        Friend(userName: "Утренний Диман", userAvatar: #imageLiteral(resourceName: "friend2"), userPhotos: [#imageLiteral(resourceName: "friend3"),#imageLiteral(resourceName: "friend1"),#imageLiteral(resourceName: "Фото Борисович")]),
        Friend(userName: "Иванов Иван", userAvatar: UIImage(named: "friend1")!, userPhotos: [#imageLiteral(resourceName: "group5"),#imageLiteral(resourceName: "friend1"),#imageLiteral(resourceName: "group4"), #imageLiteral(resourceName: "group2"), #imageLiteral(resourceName: "group3"), #imageLiteral(resourceName: "Фото Борисович")]),
        Friend(userName: "Сидоров Виктор", userAvatar: #imageLiteral(resourceName: "group3"), userPhotos: [#imageLiteral(resourceName: "group2")]),
        Friend(userName: "Корнеухов Степан", userAvatar: #imageLiteral(resourceName: "friend3"), userPhotos: [#imageLiteral(resourceName: "Фото Борисович")]),
        Friend(userName: "Сидоров Сидор", userAvatar: UIImage(named: "friend2")!, userPhotos: [#imageLiteral(resourceName: "group5"),#imageLiteral(resourceName: "friend1"),#imageLiteral(resourceName: "Фото Борисович")]),
        Friend(userName: "Petruch Petrucha", userAvatar: #imageLiteral(resourceName: "group5"), userPhotos: [#imageLiteral(resourceName: "group2")]),
        Friend(userName: "Безруков Алексей", userAvatar: #imageLiteral(resourceName: "group3"), userPhotos: [#imageLiteral(resourceName: "Фото Борисович")]),
        Friend(userName: "Tobol Petro", userAvatar: UIImage(named: "friend1")!, userPhotos: [#imageLiteral(resourceName: "group5"),#imageLiteral(resourceName: "friend1"),#imageLiteral(resourceName: "group4"), #imageLiteral(resourceName: "group2"), #imageLiteral(resourceName: "group3"), #imageLiteral(resourceName: "Фото Борисович")]),
        Friend(userName: "Ivachov Igor", userAvatar: #imageLiteral(resourceName: "group3"), userPhotos: [#imageLiteral(resourceName: "group2")]),
        Friend(userName: "Иванов Иван", userAvatar: #imageLiteral(resourceName: "friend3"), userPhotos: [#imageLiteral(resourceName: "Фото Борисович")]),
        Friend(userName: "Русский Констанотин", userAvatar: UIImage(named: "friend2")!, userPhotos: [#imageLiteral(resourceName: "group5"),#imageLiteral(resourceName: "friend1"),#imageLiteral(resourceName: "Фото Борисович")]),
        Friend(userName: "Соломин Петр", userAvatar: #imageLiteral(resourceName: "group5"), userPhotos: [#imageLiteral(resourceName: "group2")]),
        Friend(userName: "Собакин Мухтар", userAvatar: #imageLiteral(resourceName: "group3"), userPhotos: [#imageLiteral(resourceName: "Фото Борисович")]),
        Friend(userName: "Максимов Максим", userAvatar: UIImage(named: "friend1")!, userPhotos: [#imageLiteral(resourceName: "group5"),#imageLiteral(resourceName: "friend1"),#imageLiteral(resourceName: "group4"), #imageLiteral(resourceName: "group2"), #imageLiteral(resourceName: "group3"), #imageLiteral(resourceName: "Фото Борисович")]),
        Friend(userName: "Володин Виктор", userAvatar: #imageLiteral(resourceName: "group3"), userPhotos: [#imageLiteral(resourceName: "group2")]),
        Friend(userName: "Буряков Владимир", userAvatar: #imageLiteral(resourceName: "friend3"), userPhotos: [#imageLiteral(resourceName: "Фото Борисович")]),
        Friend(userName: "Иванова Сара", userAvatar: UIImage(named: "friend2")!, userPhotos: [#imageLiteral(resourceName: "group5"),#imageLiteral(resourceName: "friend1"),#imageLiteral(resourceName: "Фото Борисович")]),
        Friend(userName: "Прилука Павел", userAvatar: #imageLiteral(resourceName: "group5"), userPhotos: [#imageLiteral(resourceName: "group2")]),
        Friend(userName: "Собакин Алексей", userAvatar: #imageLiteral(resourceName: "group3"), userPhotos: [#imageLiteral(resourceName: "Фото Борисович")]),
    ]
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let friendsCell = "FriendsCell"
    let toPhotosFriend = "toPhotosFriend"
    
    var selectedFriend: Friend?
    
    //эталонный массив с именами для сравнения при поиске
    var perfectArrayWithNames: [String] = []
    
    // массив с именами меняется (при поиске) и используется в таблице
    var namesListModifed: [String] = []
    
    var letersOfNames: [String] = []
    
    // создание массива из имен пользователей
    func arrayOfUserNames() {
        
        // удаляем все элементы эталонного массива с именами
        perfectArrayWithNames.removeAll()
        
        // получаем число элементов массива
        for item in 0...(friends.count - 1) {
            
            // добавляем элементы в эталонный массив с именами
            perfectArrayWithNames.append(friends[item].userName)
        }
        namesListModifed = perfectArrayWithNames
    }
    
    // созданием массива из начальных букв имен пользователй по алфавиту
    func sortNamesAlphabetically() {
        
        var letersSet = Set<Character>()
        
        // обнуляем массив на случай повторного использования
        letersOfNames = []
        
        // создание сета из первых букв имени, чтобы не было повторов
        for name in namesListModifed {
            
            // insert - вставка элемента в определенное место массива
            letersSet.insert(name[name.startIndex])
        }
        
        // заполнение массива строк из букв имен
        // возвращам новый отсортированный массив, никак не изменяя старый
        for leter in letersSet.sorted() {
            letersOfNames.append(String(leter))
        }
    }
    
    func nameFriend(_ indexPath: IndexPath) -> String {
        var namesRows = [String]()
        for name in namesListModifed.sorted() {
            if letersOfNames[indexPath.section].contains(name.first!) {
                namesRows.append(name)
            }
        }
        return namesRows[indexPath.row]
    }
    
    func avatarFriend(_ indexPath: IndexPath) -> UIImage? {
        for friend in friends {
            let namesRows = nameFriend(indexPath)
            if friend.userName.contains(namesRows) {
                return friend.userAvatar
            }
        }
        return nil
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        searchBar.delegate = self
        arrayOfUserNames()
        sortNamesAlphabetically()
        // отпускаем строку поиска при переходе на другой экран
        //definesPresentationContext = true
    }
    
    // MARK: - searchBar
    // поиск по именам
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        namesListModifed = searchText.isEmpty ? perfectArrayWithNames : perfectArrayWithNames.filter { (item: String) -> Bool in
            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        // создаем заново массив заглавных букв для хедера
        sortNamesAlphabetically()
        tableView.reloadData()
    }
    
    // отмена поиска (через кнопку Cancel)
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true // показыть кнопку Cancel
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false // скрыть кнопку Cancel
        searchBar.text = nil
        arrayOfUserNames() // возвращаем массив имен
        sortNamesAlphabetically()  // создаем заново массив заглавных букв для хедера
        tableView.reloadData() //обновить таблицу
        searchBar.resignFirstResponder() // скрыть клавиатуру
    }
    
    // MARK: - Table view data source
    
    // количество секций
    override func numberOfSections(in tableView: UITableView) -> Int {
        // return 1
        return letersOfNames.count
        
    }
    
    // настройка хедера ячеек и добавление в него букв
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        // цвет и прозрачность хедера
        header.backgroundColor = UIColor.red.withAlphaComponent(0.2)
        // координаты размещения букв
        let leter: UILabel = UILabel(frame: CGRect(x: 27, y: 5, width: 20, height: 20))
        // цвет и прозрачность букв
        leter.textColor = UIColor.blue.withAlphaComponent(1)
        leter.text = letersOfNames[section]
        // размер и толщина букв
        leter.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.medium)
        header.addSubview(leter)
        
        return header
    }
    
    // список букв для навигации (справа контрол)
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return letersOfNames
    }
    // передаем количество элементов нашего массива (количество ячеек в секции соответствует колличеству друзей)
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var countOfRows = 0
        // сравниваем массив букв и заглавные буквы каждого имени, выводим количество ячеек в соотвествии именам на отдельную букву
        for name in namesListModifed {
            if letersOfNames[section].contains(name.first!) {
                countOfRows += 1
            }
        }
        return countOfRows
        
    }
    
    // запонение ячеек
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // получить ячейку класса FriendTableViewCell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: friendsCell, for: indexPath) as? FriendsTableViewCell else { return UITableViewCell() }
        
        cell.nameFriendLabel.text = nameFriend(indexPath)
        cell.photoImageView.image = avatarFriend(indexPath)
        
        return cell
    }
    
    // сохраняем выбранный индекс в переменной selectedFriend и убираем выделения
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedFriend = friends[indexPath.row]
        performSegue(withIdentifier: toPhotosFriend, sender: self)
    }
    
    // метод через который мы переходим на PhotosFriendCollectionViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //вызываем подготовку к переходу
        super.prepare(for: segue, sender: sender)
        
        // проверяем что индитификатор называется "toPhotosFriend"
        if segue.identifier == toPhotosFriend {
            
            // проверяем что контроллер на который мы переходим является контроллером типа PhotosFriendCollectionViewController и передаем тот или иной friend по соответствующему индексу строки
            guard let detailVC = segue.destination as? PhotosFriendCollectionViewController  else { return }
            detailVC.photos = selectedFriend
            
            // индекс нажатой ячейки
            if let indexPath = tableView.indexPathForSelectedRow {
                // заголовок для Navigation Bar
                detailVC.title = nameFriend(indexPath) 
            }
        }
    }
}
extension UITableViewController: UISearchBarDelegate {
    
}
