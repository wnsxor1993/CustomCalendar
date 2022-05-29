//
//  CalendarCollectionViewCell.swift
//  CustomCalendar
//
//  Created by juntaek.oh on 2022/05/29.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CalendarCollectionViewCell"
    private lazy var dayLabel = UILabel()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func configureLabel(text: String) {
        self.addSubview(dayLabel)
        self.dayLabel.text = text
        self.dayLabel.font = .systemFont(ofSize: 12, weight: .bold)
        
        self.dayLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.dayLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.dayLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    func setSundayColor(){
        self.dayLabel.textColor = .systemRed
    }
}
