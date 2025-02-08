//
//  Atcivment.swift
//  Atchivents
//
//  Created by Zaitsev Vladislav on 05.02.2025.
//

import UIKit

struct Achievement {
    let title: String
    let description: String
    let iconName: String
    let color: UIColor
    let maxValue: Int
    let currentValue: Int
    
    static var demoData: [Achievement] {
            return [
                Achievement(
                    title: "Повелитель мира",
                    description: "Стал президентом планеты",
                    iconName: "globe.europe.africa.fill",
                    color: .systemTeal,
                    maxValue: 1,
                    currentValue: 0
                ),
                Achievement(
                    title: "Джеймс Бонд",
                    description: "Остноновил ядерую войну голыми руками",
                    iconName: "camera.aperture",
                    color: .black,
                    maxValue: 1,
                    currentValue: 0
                ),
                Achievement(
                    title: "Покровитель всех высот",
                    description: "Покорил 5 вершин выше 4000 метров",
                    iconName: "mountain.2.fill",
                    color: .systemIndigo,
                    maxValue: 5,
                    currentValue: 3
                ),
                Achievement(
                    title: "Вегетарианец",
                    description: "Вообще не кушает мясо",
                    iconName: "leaf.fill",
                    color: .systemGreen,
                    maxValue: 1,
                    currentValue: 1
                ),
                Achievement(
                    title: "Любит понямать",
                    description: "Попробовал 30 национальных блюд",
                    iconName: "fork.knife.circle.fill",
                    color: .systemRed,
                    maxValue: 30,
                    currentValue: 30
                ),
                Achievement(
                    title: "Бог математики",
                    description: "Стал преподавателем года в Высшей Школе Экономики",
                    iconName: "books.vertical.fill",
                    color: .systemPurple,
                    maxValue: 1,
                    currentValue: 1
                ),
                Achievement(
                    title: "Домовитый",
                    description: "Очень любит свой дом",
                    iconName: "house.fill",
                    color: .systemOrange,
                    maxValue: 1,
                    currentValue: 1
                ),
                Achievement(
                    title: "Повелитель баз данных",
                    description: "Работал с 1000 базами данных",
                    iconName: "square.stack.3d.down.right.fill",
                    color: .systemCyan,
                    maxValue: 1000,
                    currentValue: 567
                )
            ]
        }
}
