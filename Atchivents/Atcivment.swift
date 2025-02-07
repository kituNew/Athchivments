//
//  Atcivment.swift
//  Atchivents
//
//  Created by Zaitsev Vladislav on 05.02.2025.
//

import UIKit

struct Atcivment {
    let title: String
    let description: String
    let iconName: String
    let color: UIColor
    let minValue: Int
    let maxValue: Int
    let currentValue: Int
    
    static var demoData: [Atcivment] {
            return [
                Atcivment(
                    title: "Повелитель мира",
                    description: "Стал президентом планеты",
                    iconName: "globe.europe.africa.fill",
                    color: .systemTeal,
                    minValue: 0,
                    maxValue: 1,
                    currentValue: 0
                ),
                Atcivment(
                    title: "Джеймс Бонд",
                    description: "Остноновил ядерую войну голыми руками",
                    iconName: "camera.aperture",
                    color: .black,
                    minValue: 0,
                    maxValue: 1,
                    currentValue: 0
                ),
                Atcivment(
                    title: "Покровитель всех высот",
                    description: "Покорил 5 вершин выше 4000 метров",
                    iconName: "mountain.2.fill",
                    color: .systemIndigo,
                    minValue: 0,
                    maxValue: 5,
                    currentValue: 3
                ),
                Atcivment(
                    title: "Вегетарианец",
                    description: "Вообще не кушает мясо",
                    iconName: "leaf.fill",
                    color: .systemGreen,
                    minValue: 0,
                    maxValue: 1,
                    currentValue: 1
                ),
                Atcivment(
                    title: "Любит понямать",
                    description: "Попробовал 30 национальных блюд",
                    iconName: "fork.knife.circle.fill",
                    color: .systemRed,
                    minValue: 0,
                    maxValue: 30,
                    currentValue: 30
                ),
                Atcivment(
                    title: "Бог математики",
                    description: "Стал преподавателем года в Высшей Школе Экономики",
                    iconName: "books.vertical.fill",
                    color: .systemPurple,
                    minValue: 0,
                    maxValue: 1,
                    currentValue: 1
                ),
                Atcivment(
                    title: "Домовитый",
                    description: "Очень любит свой дом",
                    iconName: "house.fill",
                    color: .systemOrange,
                    minValue: 0,
                    maxValue: 1,
                    currentValue: 1
                ),
                Atcivment(
                    title: "Повелитель баз данных",
                    description: "Работал с 1000 базами данных",
                    iconName: "square.stack.3d.down.right.fill",
                    color: .systemCyan,
                    minValue: 0,
                    maxValue: 1000,
                    currentValue: 567
                )
            ]
        }
}
