//
//  ViewController.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 27.02.2021.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    let login = "1"
    
    let password = "1"
    
    // Напишем логику авторизации в метод нажатия кнопки
    @IBAction func onButtonTapped(_ sender: Any) {
        // по нажатию на кнопку запускаем аниматор
        dowloadIndicatorAnimate()
        
        // откладываем время выполнения (то что в замыкании (authAction) выполнится через некоторое время)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.authAction()
        }
    }
    
    func checkLogAndPass() -> Bool {
        // Получаем текст логина
        return loginField.text == login && passwordField.text == password
    }
    
    // функция которая проверяет если логин правильный то выполняет переход
    private func authAction() {
        
        if checkLogAndPass() {
            self.performSegue(withIdentifier: "toMain", sender: self)
        } else {
            // Создаем контроллер
            let alert = UIAlertController (title: "Ошибка", message: "Введены не верные данные пользователя", preferredStyle: .alert)
            
            // Создаем кнопку для UIAlertController
            let action = UIAlertAction (title: "ОК", style: .cancel) { (action) in
                self.loginField.text = ""
                self.passwordField.text = ""
            }
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // Когда клавиатура появляется
    @objc func keyboardWasShown (notification: Notification) {
        
        // Получаем размер клавиатуры
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue) . cgRectValue.size
        let contentInsets = UIEdgeInsets (top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        
        // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    // Когда клавиатура исчезнет
    @objc func keyboardWillBeHidden (notification: Notification) {
        // Устанавливаем отступ внизу UIScrollView, равный 0
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Подписываемся на два ведомления: одно приходит при появлении клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector (self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // Второе - когда она пропадает
        NotificationCenter.default.addObserver(self, selector: #selector (self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // Добавим метод отписки при исчезновении контроллера с экрана
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    // Исчезновение клавиатуры при клике по пустому месту на экране и метод, который будет вызываться при клике
    @objc func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }
    
    // Добавим жест нажатия к UIScrollView
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // клик по любому месту scrollView для скрытия клавиатуры - Жест нажатия
        let hideKeyboardGesture = UITapGestureRecognizer (target: self, action: #selector(hideKeyboard))
        // присваиваем его UIScrollView
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
        
        // * делегаты для переноса фокуса на следующее поле ввода
        self.loginField.delegate = self
        self.passwordField.delegate = self
        
    }
    
    // Создаем метод который будет маркером для перехода назад (Unwind Segue)
    @IBAction func backToLogin (unwindSegue: UIStoryboardSegue) {
        //     При выходе очищам логин и пароль
        loginField.text = ""
        passwordField.text = ""
    }
    
    // создаем индикатор загрузки состоящий из трех точек меняющих прозрачность по очереди
    private func pointPrepare(cView: UIView, delay: Double) {
        cView.backgroundColor = .black
        view.addSubview(cView)
        // анимация индикатора загрузки
        UIView.animate(withDuration: 0.5, delay: delay, options: [.repeat, .autoreverse]) {
            cView.alpha = 0
        }
    }
    
    let point1 = UIView(frame: CGRect(x: 200, y: 500, width: 4, height: 4))
    let point2 = UIView(frame: CGRect(x: 205, y: 500, width: 4, height: 4))
    let point3 = UIView(frame: CGRect(x: 210, y: 500, width: 4, height: 4))
    
    private func dowloadIndicatorAnimate() {
        pointPrepare(cView: point1, delay: 0)
        pointPrepare(cView: point2, delay: 0.2)
        pointPrepare(cView: point3, delay: 0.4)
    }
}

