//
//  ViewController.swift
//  Lesson 7 - Choose and buy kitchen
//
//  Created by Валентин Ремизов on 24.01.2023.
//

import UIKit

class ViewController: UIViewController {

    private let classicImageView = UIImageView()
    private let classicTitleButton = UIButton()
    private let classicDescriptionLabel = UILabel()
    private let newClassicImageView = UIImageView()
    private let newClassicTitleButton = UIButton()
    private let newClassicDescriptionLabel = UILabel()
    private let hiTechImageView = UIImageView()
    private let hiTechTitleButton = UIButton()
    private let hiTechTitleDescriptionLabel = UILabel()
    private let provanceImageView = UIImageView()
    private let provanceTitleButton = UIButton()
    private let provanceDescriptionLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        //Даём загаловок странице
        title = "Стили мебели"
        //Двумя строчками получаем доступ к следующему экрану "Style"
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let feature = storyboard.instantiateViewController(identifier: "Feature") as? Feature_furniture else {return}
//MARK: - Create classic
        classicImageView.image = feature.classicImage.first as? UIImage
        classicImageView.frame = CGRect(x: 15, y: 100, width: 120, height: 120)
        //Назначаем текст на кнопке
        classicTitleButton.setTitle("Классика", for: .normal)
        classicTitleButton.frame = CGRect(x: 150, y: 100, width: 200, height: 20)
        //Назначаем цвет текста на кнопке
        classicTitleButton.setTitleColor(.black, for: .normal)
        //Делаем шрифт жирным и устанавливаем размер текста 20. Все характеристики в основном искать после "UIFont."
        classicTitleButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        //Выравниваем текст кнопки к левому краю
        classicTitleButton.contentHorizontalAlignment = .left
        classicTitleButton.titleLabel?.sizeToFit()
        //Даём кнопке действие в функции при нажатии
        classicTitleButton.addTarget(self, action: #selector(classicPassed), for: .touchUpInside)
        classicDescriptionLabel.frame = CGRect(x: 150, y: 125, width: 200, height: 120)
        classicDescriptionLabel.text = "Классика вне времени, она всегда прекрасна."
        //За счёт того что нам хватает размеров поля текста (CGRect) и мы ставим количество линий 0 - он переносит то что не помещается на новую строку
        classicDescriptionLabel.numberOfLines = 0
        classicDescriptionLabel.font = UIFont.systemFont(ofSize: 16)
        //Делает размеры view необходимых размеров для указанного текста
        classicDescriptionLabel.sizeToFit()


//MARK: - Create newclassic
        newClassicImageView.image = feature.newClassicImage.first as? UIImage
        newClassicImageView.frame = CGRect(x: 15, y: 100+120+30, width: 120, height: 120)
        newClassicTitleButton.frame = CGRect(x: 150, y: 250, width: 200, height: 20)
        newClassicTitleButton.setTitle("Новая классика", for: .normal)
        newClassicTitleButton.contentHorizontalAlignment = .left
        newClassicTitleButton.setTitleColor(.black, for: .normal)
        newClassicTitleButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        newClassicTitleButton.titleLabel?.sizeToFit()
        newClassicTitleButton.addTarget(self, action: #selector(newclassicPassed), for: .touchUpInside)
        newClassicDescriptionLabel.frame = CGRect(x: 150, y: 275, width: 200, height: 120)
        newClassicDescriptionLabel.text = "Классика идущая в ногу со временем."
        newClassicDescriptionLabel.numberOfLines = 0
        newClassicDescriptionLabel.font = UIFont.systemFont(ofSize: 16)
        newClassicDescriptionLabel.sizeToFit()


//MARK: - Create hi-tech
        hiTechImageView.image = feature.hiTechImage.first as? UIImage
        hiTechImageView.frame = CGRect(x: 15, y: 400, width: 120, height: 120)
        hiTechTitleButton.frame = CGRect(x: 150, y: 400, width: 200, height: 20)
        hiTechTitleButton.setTitle("Современный стиль", for: .normal)
        hiTechTitleButton.setTitleColor(.black, for: .normal)
        hiTechTitleButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        hiTechTitleButton.contentHorizontalAlignment = .left
        hiTechTitleButton.titleLabel?.sizeToFit()
        hiTechTitleButton.addTarget(self, action: #selector(hiTechPassed), for: .touchUpInside)
        hiTechTitleDescriptionLabel.frame = CGRect(x: 150, y: 425, width: 200, height: 120)
        hiTechTitleDescriptionLabel.text = "Минимализм и красота - именно это характеризует этот стиль."
        hiTechTitleDescriptionLabel.numberOfLines = 0
        hiTechTitleDescriptionLabel.textAlignment = .left
        hiTechTitleDescriptionLabel.font = UIFont.systemFont(ofSize: 16)
        hiTechTitleDescriptionLabel.sizeToFit()

//MARK: - Create provance
        provanceImageView.image = feature.provanceImage.first as? UIImage
        provanceImageView.frame = CGRect(x: 15, y: 550, width: 120, height: 120)
        provanceTitleButton.frame = CGRect(x: 150, y: 550, width: 200, height: 20)
        provanceTitleButton.setTitle("Прованс", for: .normal)
        provanceTitleButton.setTitleColor(.black, for: .normal)
        provanceTitleButton.contentHorizontalAlignment = .left
        provanceTitleButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        provanceTitleButton.titleLabel?.sizeToFit()
        provanceTitleButton.addTarget(self, action: #selector(provancePassed), for: .touchUpInside)
        provanceDescriptionLabel.frame = CGRect(x: 150, y: 575, width: 200, height: 120)
        provanceDescriptionLabel.text = "Неповторимый шарм от французского стиля"
        provanceDescriptionLabel.font = UIFont.systemFont(ofSize: 16)
        provanceDescriptionLabel.numberOfLines = 0
        provanceDescriptionLabel.sizeToFit()


        //Сразу все элементы добавляем через addSubview на экран
        [classicImageView, classicTitleButton, classicDescriptionLabel, newClassicImageView, newClassicTitleButton, newClassicDescriptionLabel, hiTechImageView, hiTechTitleButton, hiTechTitleDescriptionLabel, provanceImageView, provanceTitleButton, provanceDescriptionLabel].forEach {view.addSubview($0)}
    }

//MARK: - Functions
    @objc private func classicPassed (sender: UIButton) {
        guard classicTitleButton == sender else {return}
        guard let feature = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Feature") as? Feature_furniture else {return}
        feature.currentImageView.image = feature.classicImage.first as? UIImage
        feature.imageCurrentIndex = 0
        feature.titleLabel.text = classicTitleButton.currentTitle
        feature.descriptionLabel.text = classicDescriptionLabel.text
        navigationController?.pushViewController(feature, animated: true)
    }

    @objc private func newclassicPassed (sender: UIButton) {
        guard newClassicTitleButton == sender else {return}
        guard let feature = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Feature") as? Feature_furniture else {return}
        feature.currentImageView.image = feature.newClassicImage.first as? UIImage
        feature.imageCurrentIndex = 0
        feature.titleLabel.text = newClassicTitleButton.currentTitle
        feature.descriptionLabel.text = newClassicDescriptionLabel.text
        navigationController?.pushViewController(feature, animated: true)
    }

    @objc private func hiTechPassed (sender: UIButton) {
        guard hiTechTitleButton == sender else {return}
        guard let feature = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Feature") as? Feature_furniture else {return}
        feature.currentImageView.image = feature.hiTechImage.first as? UIImage
        feature.imageCurrentIndex = 0
        feature.titleLabel.text = hiTechTitleButton.currentTitle
        feature.descriptionLabel.text = hiTechTitleDescriptionLabel.text
        navigationController?.pushViewController(feature, animated: true)
    }

    @objc private func provancePassed (sender: UIButton) {
        guard provanceTitleButton == sender else {return}
        guard let feature = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Feature") as? Feature_furniture else {return}
        feature.currentImageView.image = feature.provanceImage.first as? UIImage
        feature.imageCurrentIndex = 0
        feature.titleLabel.text = provanceTitleButton.currentTitle
        feature.descriptionLabel.text = provanceDescriptionLabel.text
        navigationController?.pushViewController(feature, animated: true)
    }
}
