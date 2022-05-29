//
//  File.swift
//  CustomCalendar
//
//  Created by juntaek.oh on 2022/05/30.
//

import UIKit

struct CalendarCollectionLayout {
    
    func create() -> NSCollectionLayoutSection? {
        let itemFractionalSize: CGFloat = 1 / 7
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(itemFractionalSize), heightDimension: .fractionalHeight(itemFractionalSize))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(itemFractionalSize))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 3, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }
}
