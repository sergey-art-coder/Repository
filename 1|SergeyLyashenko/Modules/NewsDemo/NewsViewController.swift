//
//  NewsViewController.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 28.05.2021.
//

import UIKit

class NewsViewController: UIViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    
    let NewsCell = "NewsCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.dataSource = self
        
        // регестрируем ячейку
        myTableView.register(UINib(nibName: "NewsCustomTableViewCell", bundle: nil), forCellReuseIdentifier: NewsCell)
    }
}

extension NewsViewController: UITableViewDataSource {
    
    // нам передается в виде параметра сама tableView, а мы должны вернуть ей количество секций в этой таблице
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // получаем tableView  и номер секции (section), а должны вернуть количество сторок в секции
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    // нам приходит таблица и indexPath (indexPath - это структура где содержится сразу номер секции (section)и номер строки(row)), а вернуть мы должны ячейку TableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // объявляем ячейку cell и дальше из таблицы TableView мы берем любую переиспользуемую ячейку при помощи метода dequeueReusableCell (этот метод выдернит ту ячейку которая лежит освобожденная в памяти или если у нее только начало работы то он инициализирует ее) и приводим к типу NewsCustomTableViewCell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell, for: indexPath) as? NewsCustomTableViewCell else {return UITableViewCell()}
        let image = UIImage(named: "Илон Маск")
        let textAuthor = String("Маск поздравил Virgin Galactic с запуском корабля в космос")
        let postAuthor = String("Основатель и генеральный директор компании Tesla Илон Маск в своем Twitter поздравил команду аэрокосмической компания  Virgin Galactiс с успешным запуском в космос корабля VSS Unity с людьми на борту.")
        
        cell.configure(avatar: image, author: textAuthor, time: "Сегодня 19:30", post: postAuthor, postPhoto: #imageLiteral(resourceName: "Илон Маск - 1"), like: #imageLiteral(resourceName: "like"), comment: #imageLiteral(resourceName: "comment"), repost: #imageLiteral(resourceName: "repost"))

        
        return cell
    }
}
