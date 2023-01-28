//
//  Feature furniture.swift
//  Lesson 7 - Choose and buy kitchen
//
//  Created by Валентин Ремизов on 24.01.2023.
//

import UIKit

class Feature_furniture: UIViewController {

    let classicImage = [UIImage(named: "Классика 1"),
                        UIImage(named: "Классика 2"),
                        UIImage(named: "Классика 3"),
                        UIImage(named: "Классика 4")]
    let newClassicImage = [UIImage(named: "Современная классика 1"),
                           UIImage(named: "Современная классика 2"),
                           UIImage(named: "Современная классика 3"),
                           UIImage(named: "Современная классика 4")]
    let hiTechImage = [UIImage(named: "Хайтек 1"),
                       UIImage(named: "Хайтек 2"),
                       UIImage(named: "Хайтек 3"),
                       UIImage(named: "Хайтек 4")]
    let provanceImage = [UIImage(named: "Прованс 1"),
                         UIImage(named: "Прованс 2"),
                         UIImage(named: "Прованс 3"),
                         UIImage(named: "Прованс 4")]
    private let chevronLeftImage = UIImageView(image: UIImage(systemName: "chevron.left"))
    private let chevronRightImage = UIImageView(image: UIImage(systemName: "chevron.right"))
    var imageCurrentIndex = Int()

    var currentImageView = UIImageView(frame: CGRect(x: 16, y: 103, width: 361, height: 206))
    var titleLabel = UILabel(frame: CGRect(x: 16, y: 325, width: 361, height: 24))
    var descriptionLabel = UILabel(frame: CGRect(x: 16, y: 354, width: 361, height: 60))
    let facadeTextField = UITextField(frame: CGRect(x: 16, y: 425, width: 361, height: 34))
    private let facadePicker = UIPickerView()

    let facadeNameArray = ["Выберите значение", "Плёнка ПВХ", "Эмаль", "Пластик", "Массив"]
    let fittingsTextField = UITextField(frame: CGRect(x: 16, y: 467, width: 361, height: 34))
    private let fittingsPicker = UIPickerView()
    let fittingsNameArray = ["Выберите значение", "Blum (Австрия)", "Hettich (Германия)", "GTV (Польша)", "Firmax (Китай)"]
    private let bodyTextField = UITextField(frame: CGRect(x: 16, y: 509, width: 361, height: 34))
    private let bodyPicker = UIPickerView()
    let bodyNameArray = ["Выберите значение", "Egger (Австрия)", "УваДрев (Россия)"]

    private let lengthKitchenLabel = UILabel(frame: CGRect(x: 16, y: 551, width: 361, height: 34))
    private let lengthMinLabel = UILabel(frame: CGRect(x: 16, y: 589, width: 21, height: 21))
    private let lengthMaxLabel = UILabel(frame: CGRect(x: 356, y: 589, width: 21, height: 21))
    var lengthCurrentValue = UITextField(frame: CGRect(x: 171, y: 582, width: 50, height: 34))
    private let lengthSlider = UISlider(frame: CGRect(x: 14, y: 612, width: 365, height: 30))

    private let widthKitchenLabel = UILabel(frame: CGRect(x: 16, y: 637, width: 361, height: 34))
    private let widthMinLabel = UILabel(frame: CGRect(x: 16, y: 676, width: 21, height: 21))
    private let widthMaxLabel = UILabel(frame: CGRect(x: 356, y: 676, width: 21, height: 21))
    var widthCurrentValue = UITextField(frame: CGRect(x: 171, y: 669, width: 50, height: 34))
    private let widthSlider = UISlider(frame: CGRect(x: 14, y: 699, width: 365, height: 30))

    private var nextButton = UIButton(type: .roundedRect)

    override func viewDidLoad() {
        super.viewDidLoad()
        //Даём загаловок странице
        title = "Характеристики"
        chevronLeftImage.frame = CGRect(x: 23, y: 194, width: 20, height: 25)
        chevronLeftImage.tintColor = .white
        chevronRightImage.frame = CGRect(x: 350, y: 194, width: 20, height: 25)
        chevronRightImage.tintColor = .white

        let nextChevronGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(nextChevronPressed))
        chevronRightImage.isUserInteractionEnabled = true
        chevronRightImage.addGestureRecognizer(nextChevronGestureRecognizer)
        let backChevronGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backChevronPressed))
        chevronLeftImage.isUserInteractionEnabled = true
        chevronLeftImage.addGestureRecognizer(backChevronGestureRecognizer)

        facadePicker.tag = 0
        fittingsPicker.tag = 1
        bodyPicker.tag = 2

        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.numberOfLines = 2


        facadeTextField.placeholder = "Выберите материал фасада"
        facadeTextField.inputView = facadePicker
        facadeTextField.inputAccessoryView = createToolBarFacade()
        //Это стиль этой линийй вокруг строчки (нету линии, углы и жирная рамка, закругленные углы и норм рамка)
        facadeTextField.borderStyle = .roundedRect
        facadePicker.dataSource = self
        facadePicker.delegate = self

        fittingsTextField.placeholder = "Выберите фурнитуру"
        fittingsTextField.inputView = fittingsPicker
        fittingsTextField.inputAccessoryView = createToolBarFittings()
        fittingsTextField.borderStyle = .roundedRect
        fittingsPicker.delegate = self
        fittingsPicker.dataSource = self

        bodyTextField.placeholder = "Выберите корпус мебели"
        bodyTextField.inputView = bodyPicker
        bodyTextField.inputAccessoryView = createToolBarBody()
        bodyTextField.borderStyle = .roundedRect
        bodyPicker.delegate = self
        bodyPicker.dataSource = self

        lengthKitchenLabel.textAlignment = .center
        lengthKitchenLabel.text = "Укажите длину кухни"
        lengthMinLabel.textAlignment = .left
        lengthMinLabel.text = "1"
        lengthMaxLabel.textAlignment = .right
        lengthMaxLabel.text = "5"
        lengthCurrentValue.textAlignment = .center
        lengthCurrentValue.borderStyle = .roundedRect
        lengthCurrentValue.isUserInteractionEnabled = false
        lengthSlider.minimumValue = 1
        lengthSlider.maximumValue = 5
        lengthSlider.addTarget(self, action: #selector(lengthSliderEdit), for: .valueChanged)

        widthKitchenLabel.textAlignment = .center
        widthKitchenLabel.text = "Укажите ширину кухни"
        widthMinLabel.textAlignment = .left
        widthMinLabel.text = "1"
        widthMaxLabel.textAlignment = .right
        widthMaxLabel.text = "5"
        widthCurrentValue.textAlignment = .center
        widthCurrentValue.borderStyle = .roundedRect
        widthCurrentValue.isUserInteractionEnabled = false
        widthSlider.minimumValue = 1
        widthSlider.maximumValue = 5
        widthSlider.addTarget(self, action: #selector(widthSliderEdit), for: .valueChanged)

        nextButton.frame = CGRect(x: 31, y: 749, width: 330, height: 50)
        nextButton.setTitle("Рассчитать стоимость", for: .normal)
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.backgroundColor = .blue
        //Этой строчкой мы делаем кнопку с закругленными краями независимо от её размером
        nextButton.layer.cornerRadius = nextButton.frame.size.height / 2
        nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)

        [titleLabel, facadeTextField, fittingsTextField, bodyTextField, descriptionLabel, lengthKitchenLabel, lengthMinLabel, lengthMaxLabel, lengthCurrentValue, lengthSlider, widthKitchenLabel, widthMinLabel, widthMaxLabel, widthCurrentValue, widthSlider, nextButton, currentImageView, chevronLeftImage, chevronRightImage].forEach {view.addSubview($0)}
    }

    @objc func nextChevronPressed() {
        imageCurrentIndex += 1
        if titleLabel.text == "Классика" {
            switch imageCurrentIndex {
            case 0...3 : currentImageView.image = classicImage[imageCurrentIndex]
            default : imageCurrentIndex = 0; currentImageView.image = classicImage[imageCurrentIndex]
            }
        } else if titleLabel.text == "Новая классика" {
            switch imageCurrentIndex {
            case 0...3 : currentImageView.image = newClassicImage[imageCurrentIndex]
            default : imageCurrentIndex = 0; currentImageView.image = newClassicImage[imageCurrentIndex]
            }
        } else if titleLabel.text == "Современный стиль" {
            switch imageCurrentIndex {
            case 0...3 : currentImageView.image = hiTechImage[imageCurrentIndex]
            default : imageCurrentIndex = 0; currentImageView.image = hiTechImage[imageCurrentIndex]
            }
        } else if titleLabel.text == "Прованс" {
            switch imageCurrentIndex {
            case 0...3 : currentImageView.image = provanceImage[imageCurrentIndex]
            default : imageCurrentIndex = 0; currentImageView.image = provanceImage[imageCurrentIndex]
            }
        }
    }

    @objc func backChevronPressed() {
        imageCurrentIndex -= 1
        if titleLabel.text == "Классика" {
            switch imageCurrentIndex {
            case 0...3 : currentImageView.image = classicImage[imageCurrentIndex]
            default : imageCurrentIndex = 3; currentImageView.image = classicImage[imageCurrentIndex]
            }
        } else if titleLabel.text == "Новая классика" {
            switch imageCurrentIndex {
            case 0...3 : currentImageView.image = newClassicImage[imageCurrentIndex]
            default : imageCurrentIndex = 3; currentImageView.image = newClassicImage[imageCurrentIndex]
            }
        } else if titleLabel.text == "Современный стиль" {
            switch imageCurrentIndex {
            case 0...3 : currentImageView.image = hiTechImage[imageCurrentIndex]
            default : imageCurrentIndex = 3; currentImageView.image = hiTechImage[imageCurrentIndex]
            }
        } else if titleLabel.text == "Прованс" {
            switch imageCurrentIndex {
            case 0...3 : currentImageView.image = provanceImage[imageCurrentIndex]
            default : imageCurrentIndex = 3; currentImageView.image = provanceImage[imageCurrentIndex]
            }
        }
    }

    @objc func lengthSliderEdit (sender: UISlider) {
        guard sender == lengthSlider else { return }
        //Этой строчкой мы отображаем изменения слайдера в цифрах в отдельном поле и ещё здесь мы округляем число до 2-х чисел после запятой.
        lengthCurrentValue.text = "\(Double(round(100 * Double(lengthSlider.value)) / 100))"
    }

    @objc func widthSliderEdit (sender: UISlider) {
        guard sender == widthSlider else { return }
        widthCurrentValue.text = "\(Double(round(100 * Double(widthSlider.value)) / 100))"
    }

    @objc func nextButtonPressed (sender: UIButton) {
        guard sender == nextButton else { return }
        guard let puchaseViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Puchase") as? Puchase else { return }
        //Как я вычитал в инете, чтоб привести к числу abc.text нужно сначала его раскрыть безопасно и потом только уже применять. Только зачем Double раскрывать - непонятно.
        if let length = lengthCurrentValue.text, let width = widthCurrentValue.text {
            puchaseViewController.totalMinPriceDouble = ((Double(length) ?? 0) + (Double(width) ?? 0) - 0.6) * 40000
        }

        puchaseViewController.selectedFacadeString = facadeTextField.text ?? ""
        puchaseViewController.selectedFittingsString = fittingsTextField.text ?? ""
        puchaseViewController.selectedBodyString = bodyTextField.text ?? ""
        navigationController?.pushViewController(puchaseViewController, animated: true)
    }
}

//MARK: - Extension
extension Feature_furniture: UIPickerViewDelegate, UIPickerViewDataSource {


    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 0 : return facadeNameArray.count
        case 1 : return fittingsNameArray.count
        case 2 : return bodyNameArray.count
        default : return 0
        }
    }

    //Этим методом указываем что будет вообще показываться в наших строчках
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 0 : return facadeNameArray[row]
        case 1 : return fittingsNameArray[row]
        case 2 : return bodyNameArray[row]
        default : return "Не выбрано значение"
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 0 : if row == 0 {
            facadeTextField.text = nil
        } else {
            facadeTextField.text = facadeNameArray[row]
        }

        case 1 : if row == 0 {
            fittingsTextField.text = nil
        } else {
            fittingsTextField.text = fittingsNameArray[row]
        }

        case 2 : if row == 0 {
            bodyTextField.text = nil
        } else {
            bodyTextField.text = bodyNameArray[row]
        }
        default : break
        }
    }

//MARK: - Created Tool Bars
    func createToolBarFacade() -> UIToolbar {
        //Создаём tool bar
        let toolBar = UIToolbar()
        //устанавливается размер скорее всего
        toolBar.sizeToFit()

        //Создаётся кнопка done/cancel
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donePressed))
        //И добавляется в tool bar я так понимаю
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressedFacade))
        toolBar.setItems([doneButton, cancelButton], animated: true)

        return toolBar
    }

    @objc func donePressed () {
        facadeTextField.resignFirstResponder()
        fittingsTextField.resignFirstResponder()
        bodyTextField.resignFirstResponder()
    }

    @objc func cancelPressedFacade () {
        facadeTextField.text = nil
        facadeTextField.resignFirstResponder()
    }

    func createToolBarFittings () -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donePressed))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressedFittings))
        toolBar.setItems([doneButton, cancelButton], animated: true)
        return toolBar
    }

    @objc func cancelPressedFittings () {
        fittingsTextField.text = nil
        fittingsTextField.resignFirstResponder()
    }

    func createToolBarBody () -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donePressed))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressedBody))
        toolBar.setItems([doneButton, cancelButton], animated: true)
        return toolBar
    }

    @objc func cancelPressedBody () {
        bodyTextField.text = nil
        bodyTextField.resignFirstResponder()
    }
}
