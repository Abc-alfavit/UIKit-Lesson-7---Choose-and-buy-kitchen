//
//  Puchase.swift
//  Lesson 7 - Choose and buy kitchen
//
//  Created by Валентин Ремизов on 24.01.2023.
//

import UIKit

class Puchase: UIViewController {

    private let descriptionPageLabel = UILabel(frame: CGRect(x: 31, y: 89, width: 330, height: 60))
    private let firstNameTextField = UITextField(frame: CGRect(x: 31, y: 157, width: 330, height: 34))
    private let lastNameTextField = UITextField(frame: CGRect(x: 31, y: 199, width: 330, height: 34))
    private let middleNameTextField = UITextField(frame: CGRect(x: 31, y: 241, width: 330, height: 34))
    private let methodPayLabel = UILabel(frame: CGRect(x: 31, y: 283, width: 330, height: 34))
    private let methodPaySegmentedControl = UISegmentedControl(items: ["Наличные", "Карта"])
    private let assemblyLabel = UILabel(frame: CGRect(x: 31, y: 364, width: 330, height: 34))
    private let assemblySegmentedControl = UISegmentedControl(items: ["Нет", "Да"])
    private let deliveryLabel = UILabel(frame: CGRect(x: 31, y: 445, width: 330, height: 34))
    private let deliverySegmentedControl = UISegmentedControl(items: ["Нет", "Да"])
    private let chooseDateTextField = UITextField(frame: CGRect(x: 31, y: 533, width: 330, height: 34))
    private let deliveryDatePicker = UIDatePicker()
    private let totalPrice = UILabel(frame: CGRect(x: 31, y: 596, width: 330, height: 34))
    private let totalPriceValueLabel = UILabel(frame: CGRect(x: 31, y: 638, width: 330, height: 34))
    private let editButton = UIButton(type: .roundedRect)
    private let buyButton = UIButton(type: .roundedRect)
    var totalMinPriceDouble = Double()
    var selectedFacadeString = String()
    var selectedFittingsString = String()
    var selectedBodyString = String()
    var assemblyRateDouble = Double()
    var methodPayRateDouble = Double()
    var deliveryRateDouble = Double()

    override func viewDidLoad() {
        super.viewDidLoad()
        //Даём загаловок странице
        title = "Оформление"

        descriptionPageLabel.text = "Для точного расчёта заполните все данные"
        descriptionPageLabel.isUserInteractionEnabled = false
        descriptionPageLabel.textAlignment = .center
        descriptionPageLabel.numberOfLines = 0
        descriptionPageLabel.font = UIFont.systemFont(ofSize: 16)

        firstNameTextField.placeholder = "Имя"
        firstNameTextField.borderStyle = .roundedRect
        lastNameTextField.placeholder = "Фамилия"
        lastNameTextField.borderStyle = .roundedRect
        middleNameTextField.placeholder = "Отчество"
        middleNameTextField.borderStyle = .roundedRect

        methodPayLabel.text = "Выберите способ оплаты"
        methodPayLabel.textAlignment = .center
        methodPayLabel.numberOfLines = 0
        methodPayLabel.isUserInteractionEnabled = false
        methodPaySegmentedControl.frame = CGRect(x: 31, y: 325, width: 330, height: 32)
        //Выбирает определенный вариант ответа уже выбранным по умолчанию
        methodPaySegmentedControl.selectedSegmentIndex = 0
        methodPaySegmentedControl.addTarget(self, action: #selector(methodPaySegmentedControlPressed), for: .valueChanged)

        assemblyLabel.text = "Потребуется сборка мебели?"
        assemblyLabel.isUserInteractionEnabled = false
        assemblyLabel.textAlignment = .center
        assemblyLabel.numberOfLines = 0
        assemblySegmentedControl.frame = CGRect(x: 31, y: 406, width: 330, height: 34)
        assemblySegmentedControl.selectedSegmentIndex = 0
        assemblySegmentedControl.addTarget(self, action: #selector(assemblySegmentedControlPressed), for: .valueChanged)

        deliveryLabel.text = "Нужна ли доставка?"
        deliveryLabel.numberOfLines = 0
        deliveryLabel.textAlignment = .center
        deliveryLabel.isUserInteractionEnabled = false
        deliverySegmentedControl.frame = CGRect(x: 31, y: 487, width: 330, height: 34)
        deliverySegmentedControl.selectedSegmentIndex = 0
        deliverySegmentedControl.addTarget(self, action: #selector(deliverySegmentedControlPressed), for: .valueChanged)

        chooseDateTextField.borderStyle = .roundedRect
        chooseDateTextField.placeholder = "Выберите дату доставки"
        chooseDateTextField.isEnabled = false
        createDatepicker()

        totalPrice.text = "Окончательная стоимость"
        totalPrice.isUserInteractionEnabled = false
        totalPrice.textAlignment = .center
        totalPrice.numberOfLines = 0
        totalPrice.font = UIFont.boldSystemFont(ofSize: 18)

        totalPriceValueLabel.text = "\(calculatePrice()) ₽"
        totalPriceValueLabel.isUserInteractionEnabled = false
        totalPriceValueLabel.textAlignment = .center
        totalPriceValueLabel.numberOfLines = 0
        totalPriceValueLabel.font = UIFont.boldSystemFont(ofSize: 30)

        editButton.frame = CGRect(x: 31, y: 700, width: 330, height: 50)
        editButton.setTitle("Пересчитать", for: .normal)
        editButton.setTitleColor(.white, for: .normal)
        editButton.backgroundColor = .blue
        //Делаем закругления кнопке
        editButton.layer.cornerRadius = editButton.frame.size.height / 2
        editButton.addTarget(self, action: #selector(editButtonPressed), for: .allTouchEvents)

        buyButton.frame = CGRect(x: 31, y: 759, width: 330, height: 50)
        buyButton.setTitle("Заказать", for: .normal)
        buyButton.setTitleColor(.white, for: .normal)
        buyButton.backgroundColor = .systemGreen
        buyButton.layer.cornerRadius = buyButton.frame.size.height / 2
        buyButton.addTarget(self, action: #selector(buyButtonPressed), for: .allTouchEvents)

        [descriptionPageLabel, firstNameTextField, lastNameTextField, middleNameTextField, methodPayLabel, methodPaySegmentedControl, assemblyLabel, assemblySegmentedControl, deliveryLabel, deliverySegmentedControl, chooseDateTextField, totalPrice, totalPriceValueLabel, editButton, buyButton].forEach{view.addSubview($0)}
    }

    @objc func methodPaySegmentedControlPressed (sender : UISegmentedControl) {
        if methodPaySegmentedControl.selectedSegmentIndex == 1 {
            methodPayRateDouble = 0.08
        } else {
            methodPayRateDouble = 0
        }
        totalPriceValueLabel.text = "\(calculatePrice()) ₽"
    }

    @objc func assemblySegmentedControlPressed (sender : UISegmentedControl) {
        if assemblySegmentedControl.selectedSegmentIndex == 1 {
            assemblyRateDouble = 0.1
        } else {
            assemblyRateDouble = 0
        }
        //Эта строка нужна для того, чтоб сумма в реальном времени обновлялась
        totalPriceValueLabel.text = "\(calculatePrice()) ₽"
    }

    @objc func deliverySegmentedControlPressed (sender : UISegmentedControl) {
        if deliverySegmentedControl.selectedSegmentIndex == 1 {
            chooseDateTextField.isEnabled = true
            deliveryRateDouble = 5000
        } else {
            chooseDateTextField.isEnabled = false
            deliveryRateDouble = 0
        }
        totalPriceValueLabel.text = "\(calculatePrice()) ₽"
    }

    func createDatepicker() {
        //Сначала задаём стиль пикера (календарь)
        deliveryDatePicker.preferredDatePickerStyle = .inline
        //Обозначаем что там будет содержаться - дата
        deliveryDatePicker.datePickerMode = .date
        //Присваиваем наш пикер с датой в текстовое поле, чтоб открывался пикер при нажатии
        chooseDateTextField.inputView = deliveryDatePicker
        //Присваиваем нашему пикеру в текстовом поле tool bar
        chooseDateTextField.inputAccessoryView = toolBarDatePicker()

        //Создаём переменную с TimeInterval и назначаем в неё тот интервал, который нам нужен, который будет активен
        var oneMonthInterval = TimeInterval()
        oneMonthInterval = 31 * 24 * 60 * 60
        //Date - это текущая дата и время (сегодня)
        let todayDate = Date()
        //addingTimeInterval прибавляет к todayDate тот интервал, который указан в oneMonthInterval. То есть если у нас диапазон будет месяц от сегодняшнего дня, то в качестве конца доступного интервала мы используем переменную oneMonthFromDate, а если нужно не от сегодняшнего дня, а спустя 1 месяц от сегодняшнего дня, то мы создаем еще одну переменную аналогично как ниже и указываем addingTimeInterval(2 * oneMonthInterval)
        let oneMonthFromDate = todayDate.addingTimeInterval(oneMonthInterval)
        deliveryDatePicker.minimumDate = todayDate
        deliveryDatePicker.maximumDate = oneMonthFromDate
    }

    @objc func donePressedDatePicker() {
        //Создаём формат даты в виде константы
        let dateFormatter = DateFormatter()
        //Назначаем константе средний по длине формат даты
        dateFormatter.dateStyle = .medium
        //Назначаем константе длину времени - в этом случае без него
        dateFormatter.timeStyle = .none

        //Назначаем нашему текстовому полю нашу дату в виде строки в таком формате, который 2-мя строчками выше назначили
        self.chooseDateTextField.text = dateFormatter.string(from: deliveryDatePicker.date)
        self.view.endEditing(true)
    }

    @objc func cancelPressedDatePicker() {
        chooseDateTextField.text = nil
        chooseDateTextField.resignFirstResponder()
    }

    func toolBarDatePicker() -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donePressedDatePicker))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressedDatePicker))
        toolBar.setItems([doneButton, cancelButton], animated: true)
        return toolBar
    }

    @objc func editButtonPressed() {
        navigationController?.popViewController(animated: true)
    }

    @objc func buyButtonPressed() {
        let alertController = UIAlertController(title: "", message: "Нажимая \"Подтвердить\" Вы соглашаетесь с нашей политикой обработки персональных данных", preferredStyle: .alert)
        let alertDoneAction = UIAlertAction(title: "Подтвердить", style: .default) { _ in
            let alertController2 = UIAlertController(title: "Ваш заказ принят", message: "Благодарим Вас за оформленный заказ, мы уверены - это лучшая Ваша покупка за сегодня. Хорошего Вам дня!", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "ОК", style: .default)
            alertController2.addAction(alertAction)
            self.present(alertController2, animated: true)
        }
        let alertCancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        [alertDoneAction, alertCancelAction].forEach{alertController.addAction($0)}
        present(alertController, animated: true)
    }

    func calculatePrice() -> Int {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let feature = storyboard.instantiateViewController(withIdentifier: "Feature") as? Feature_furniture else { return 100 }

        var facadeDouble = Double()
        if selectedFacadeString == feature.facadeNameArray[1] {
            facadeDouble = 1
        } else if selectedFacadeString == feature.facadeNameArray[2] {
            facadeDouble = 1.15
        } else if selectedFacadeString == feature.facadeNameArray[3] {
            facadeDouble = 1.2
        } else {
            facadeDouble = 1.3
        }

        var fittingsDouble = Double()
        if selectedFittingsString == feature.fittingsNameArray[1] || feature.fittingsTextField.text == feature.fittingsNameArray[2] {
            fittingsDouble = 0.15
        } else if selectedFittingsString == feature.fittingsNameArray[3] {
            fittingsDouble = 0.05
        } else {
            fittingsDouble = 0
        }

        var bodyDouble = Double()
        if selectedBodyString == feature.bodyNameArray[1] {
            bodyDouble = 0.1
        } else {
            bodyDouble = 0
        }

        let totalPrice = Int((totalMinPriceDouble * facadeDouble) + (totalMinPriceDouble * fittingsDouble) + (totalMinPriceDouble * bodyDouble) + (totalMinPriceDouble * assemblyRateDouble) + (totalMinPriceDouble * methodPayRateDouble) + deliveryRateDouble)

        return totalPrice
    }
}
